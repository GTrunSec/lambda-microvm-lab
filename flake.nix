{
  description = "Lambda Microvm For Hunting Lab";
  nixConfig.extra-substituters = "https://zeek.cachix.org";
  nixConfig.extra-trusted-public-keys = "zeek.cachix.org-1:w590YE/k5sB26LSWvDCI3dccCXipBwyPenhBH2WNDWI=";
  nixConfig = {
    flake-registry = "https://github.com/hardenedlinux/flake-registry/raw/main/flake-registry.json";
  };
  inputs = {
    flake-compat.flake = false;
    nixpkgs.url = "github:NixOS/nixpkgs/release-21.11";
    # microvm.url = "github:GTrunSec/microvm.nix/interface";
    microvm.url = "/home/gtrun/ghq/github.com/astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
    cells.url = "github:gtrunsec/DevSecOps-cells";
    digga = {
      url = "github:divnix/digga";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.follows = "devshell";
    };
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {url = "github:Mic92/sops-nix";};
    vast2nix = {url = "github:gtrunsec/vast2nix";};
    nomad-driver = {
      url = "github:input-output-hk/nomad-driver-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    cells,
    latest,
    flake-compat,
    devshell,
    digga,
    home,
    microvm,
    nomad-driver,
    zeek2nix,
    vast2nix,
    threatbus2nix,
    nixpkgs-hardenedlinux,
    sops-nix,
    ragenix,
  }:
    digga.lib.mkFlake {
      inherit self inputs;

      supportedSystems = ["x86_64-linux"];

      channels = import ./channels {inherit self inputs;};

      channelsConfig = {
        allowBroken = true;
        allowUnfree = true;
      };

      lib = import ./lib {lib = digga.lib // nixpkgs.lib;};

      sharedOverlays = import ./overlays/share {inherit self inputs;};

      devshell = ./devshell;

      nixos = ./nixos;

      home = ./users;
      ########################
      # # Builder Packages   #
      ########################
      outputsBuilder = channels: import ./pkgs/output-builder channels inputs self;
    };
}
