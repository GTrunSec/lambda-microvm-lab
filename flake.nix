{
  description = "A highly structured configuration database => User:Guangtao";

  nixConfig.extra-substituters = ["https://microvm.cachix.org" "https://zeek.cachix.org"];
  nixConfig.extra-trusted-public-keys = [
    "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
    "zeek.cachix.org-1:w590YE/k5sB26LSWvDCI3dccCXipBwyPenhBH2WNDWI="
  ];

  inputs = {
    ##################
    # Default Flakes #
    ##################
    nixos.url = "github:NixOS/nixpkgs/release-22.05";
    # nixos.url = "github:NixOS/nixpkgs/release-22.05";
    nixos-latest.url = "github:NixOS/nixpkgs/master";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos_21_05.url = "github:NixOS/nixpkgs/nixos-21.05";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixos";

    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixos";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-generators.url = "github:nix-community/nixos-generators";

    microvm.url = "github:astro/microvm.nix";
  };

  ###################
  # Darwin Channels #
  ###################
  inputs = {
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "darwin-nixpkgs";
    darwin-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    darwin-emacs.url = "github:cmacrae/emacs/12e55b55cba2648a53bdcde12e9ecc397a130507";
  };

  inputs = {
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.devshell.follows = "devshell";
    digga.inputs.flake-utils-plus.follows = "flake-utils-plus";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  ####################
  # Default Features #
  ####################
  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixos";

    vault-secrets.url = "github:gtrunsec/vault-secrets";

    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixos";

    emacs-overlay.url = "github:nix-community/emacs-overlay/27fea646189ff7572453e1e3a4d1eb9dc5887fb2";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
  };

  #################
  # Custom Flakes #
  #################
  inputs = {
    nomad-driver.url = "github:input-output-hk/nomad-driver-nix";
    nomad-driver.inputs.nixpkgs.follows = "nixos";

    zeek2nix.url = "github:hardenedlinux/zeek2nix";
    vast2nix.url = "github:gtrunsec/vast2nix";
    threatbus2nix.url = "github:gtrunsec/threatbus2nix";
    airflow2nix.url = "github:gtrunsec/airflow2nix";

    waterwheel.url = "github:gtrunsec/waterwheel/nix";
    waterwheel.inputs.nixpkgs.follows = "nixos";
  };

  outputs = {
    self,
    digga,
    ...
  } @ inputs:
    digga.lib.mkFlake
    {
      inherit self inputs;

      supportedSystems = ["x86_64-linux"];

      channelsConfig = {allowUnfree = true;};

      channels = import ./channels inputs;

      lib = import ./lib {lib = digga.lib // inputs.nixos.lib;};

      sharedOverlays = import ./overlays/shared inputs;

      devshell = ./devshell;

      nixos = ./nixos;

      # darwin = ./darwin;

      home = ./home;

      homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;
      ########################
      # # Builder Packages   #
      ########################
      outputsBuilder = channels: import ./pkgs/output-builder channels inputs self;
    };
}
