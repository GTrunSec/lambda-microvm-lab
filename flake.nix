{
  description = "lambda-micro-vms for hunting-lab";
  nixConfig.extra-substituters = "https://zeek.cachix.org";
  nixConfig.extra-trusted-public-keys = "zeek.cachix.org-1:w590YE/k5sB26LSWvDCI3dccCXipBwyPenhBH2WNDWI=";
  nixConfig = {
    flake-registry = "https://github.com/hardenedlinux/flake-registry/raw/main/flake-registry.json";
  };
  inputs = {
    flake-compat.flake = false;
    microvm.url = "/home/gtrun/ghq/github.com/astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
    bud = {
      url = "github:GTrunSec/bud/extend";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.follows = "devshell";
    };
    digga = {
      url = "github:divnix/digga";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.follows = "devshell";
    };
    sops-nix = { url = "github:Mic92/sops-nix"; };
    vast2nix = {
      url = "/home/gtrun/ghq/github.com/GTrunSec/vast2nix";
      #url = "github:gtrunsec/vast/fix-flake";
    };
  };
  outputs = inputs @
  { self
  , nixpkgs
  , latest
  , flake-utils
  , flake-compat
  , devshell
  , bud
  , digga
  , microvm
  , zeek2nix
  , vast2nix
  , threatbus2nix
  , sops-nix
  }:
  digga.lib.mkFlake {
    inherit self inputs;
    # Supported systems, used for packages, apps, devShell and multiple other definitions. Defaults to `flake-utils.lib.defaultSystems`
    supportedSystems = [ "x86_64-linux" ];
    channels = import ./channels { inherit self inputs; };
    channelsConfig = {
      allowBroken = true;
      allowUnfree = true;
    };
    lib = import ./lib { lib = digga.lib // nixpkgs.lib; };
    sharedOverlays = import ./overlays/share { inherit self inputs; };
    devshell = ./shell;
    nixos = ./nixos;
    ########################
    # # Builder Packages   #
    ########################
    outputsBuilder = channels: import ./pkgs/output-builder channels inputs self;
  }
  // {
    ####################################
    # Deploy-rs Modules Infrastructure #
    ####################################
    budModules = {
      vm-lab = {
        category = "general commands";
        description = "highly customizable system ctl for VM hunting lab";
        path = import ./shell/microvm-hunting-lab;
      };
    };
  };
}
