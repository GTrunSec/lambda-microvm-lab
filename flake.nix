{
  description = "lambda-micro-vms for hunting-lab";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/release-21.11";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    devshell.url = "github:numtide/devshell";
    bud = {
      url = "github:GTrunSec/bud/custom";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.follows = "devshell";
    };
    microvm.follows = "zeek2nix/nixpkgs-hardenedlinux/microvm";
    zeek2nix = {
      url = "github:hardenedlinux/zeek2nix";
      inputs.microvm.follows = "zeek2nix/nixpkgs-hardenedlinux/microvm";
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
        devShell = import ./shell { inherit self inputs pkgs; };
        packages = inputs.flake-utils.lib.flattenTree {
          qemu-microvm-bridge = microvm.lib.runner {
            inherit system;
            hypervisor = "qemu";
            nixosConfig = { pkgs, ... }: {
              networking.hostName = "qemu-microvm";
              users.users.root.password = "";
            } // import ./hosts/bridge.nix { inherit pkgs self inputs; };
            interfaces = [{
              type = "bridge,br=virbr0";
              id = "qemu-eth0";
              mac = "00:02:00:01:01:01";
            }];
            volumes = [{
              mountpoint = "/var";
              image = "/tmp/microvm-qemu-hunting-lab.img";
              size = 256;
            }];
            socket = "control.socket";
          };
        };
      })
    ) //
    {
      overlay = final: prev: { };
      budModules = {
        inherit (inputs.zeek.packages) zeek-release;
        microvm-hunting-lab = import ./shell/microvm-hunting-lab;
      };
    };
}
