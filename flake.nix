{
  description = "lambda-micro-vms for hunting-lab";
  nixConfig.extra-substituters = "https://zeek.cachix.org";
  nixConfig.extra-trusted-public-keys = "zeek.cachix.org-1:w590YE/k5sB26LSWvDCI3dccCXipBwyPenhBH2WNDWI=";
  nixConfig = {
    flake-registry = "https://github.com/hardenedlinux/flake-registry/raw/main/flake-registry.json";
  };


  inputs = {
    flake-compat.flake = false;
    bud = {
      url = "github:GTrunSec/bud/extend";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.follows = "devshell";
    };
    vast-flake = {
      #url = "/home/gtrun/ghq/github.com/GTrunSec/vast";
      url = "github:gtrunsec/vast/fix-flake";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , flake-utils
    , flake-compat
    , devshell
    , bud
    , microvm
    , zeek2nix
    , vast-flake
    }:
    { }
    //
    (flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlay
            devshell.overlay
          ];
        };
      in
      rec {
        devShell =
          let
            eval = import "${devshell}/modules" pkgs;
            configuration = {
              name = pkgs.lib.mkDefault "devshell";
              imports =
                let
                  devshell = import ./shell {
                    inherit self inputs pkgs;
                  };
                in
                devshell.modules ++ devshell.exportedModules;
            };
          in
          (eval {
            inherit configuration;
            extraSpecialArgs = { inherit self inputs; };
          }).shell;

        packages = inputs.flake-utils.lib.flattenTree
          {
            qemu-microvm-bridge = import ./hosts/bridge.nix {
              inherit self inputs pkgs system;
            };
          };
      })
    ) //
    {
      overlay = final: prev: {
        inherit (inputs.zeek.packages) zeek-release;
      };
      budModules = {
        vm-lab = { category = "general commands"; description = "highly customizable system ctl for VM hunting lab"; path = import ./shell/microvm-hunting-lab; };
      };
    };
}
