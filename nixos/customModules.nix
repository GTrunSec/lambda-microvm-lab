inputs:
with inputs; {
  nsm = [
    zeek2nix.nixosModules.zeek
    vast2nix.nixosModules.vast
    vast2nix.nixosModules.vast-client

    threatbus2nix.nixosModules.threatbus
    threatbus2nix.nixosModules.threatbus-vast
  ];
  secrets = [ragenix.nixosModules.age];

  nomad = [
    nomad-driver.nixosModules.nix-driver-nomad
    "${nixpkgs}/nixos/modules/misc/version.nix"
    "${nixpkgs}/nixos/modules/profiles/base.nix"
    "${nixpkgs}/nixos/modules/profiles/headless.nix"
    "${nixpkgs}/nixos/modules/profiles/minimal.nix"
    "${nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
  ];
}
