{
  description = "Lambda Microvm For Hunting Lab";
  nixConfig.extra-substituters = "https://zeek.cachix.org";
  nixConfig.extra-trusted-public-keys = "zeek.cachix.org-1:w590YE/k5sB26LSWvDCI3dccCXipBwyPenhBH2WNDWI=";
  nixConfig = {
    flake-registry = "https://github.com/hardenedlinux/flake-registry/raw/main/flake-registry.json";
  };
  inputs = {
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "microvm/nixpkgs";
    latest.url = "github:NixOS/nixpkgs/master";

    microvm.url = "github:astro/microvm.nix";
    #microvm.url = "/home/gtrun/ghq/github.com/astro/microvm.nix";

    cells.url = "github:gtrunsec/DevSecOps-cells";

    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixpkgs";
    digga.inputs.devshell.follows = "devshell";
    digga.inputs.flake-utils-plus.follows = "flake-utils-plus";

    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";

    vault-secrets.url = "github:gtrunsec/vault-secrets";

    nomad-driver.url = "github:input-output-hk/nomad-driver-nix";
    nomad-driver.inputs.nixpkgs.follows = "nixpkgs";

    zeek2nix.url = "github:hardenedlinux/zeek2nix";
    vast2nix.url = "github:gtrunsec/vast2nix";
    threatbus2nix.url = "github:gtrunsec/threatbus2nix";
    airflow2nix.url = "github:gtrunsec/airflow2nix";

    waterwheel.url = "/home/gtrun/ghq/github.com/sphenlee/waterwheel";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    digga,
    ...
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
