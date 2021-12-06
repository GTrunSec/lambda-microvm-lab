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
        packages = inputs.flake-utils.lib.flattenTree
          {
            qemu-microvm-bridge = import ./hosts/bridge.nix { inherit self inputs pkgs system; };
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
