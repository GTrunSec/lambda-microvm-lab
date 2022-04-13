{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nomad-driver.nixosModules.nix-driver-nomad
    "${pkgs}/nixos/modules/misc/version.nix"
    "${pkgs}/nixos/modules/profiles/base.nix"
    "${pkgs}/nixos/modules/profiles/headless.nix"
    "${pkgs}/nixos/modules/profiles/minimal.nix"
  ];
}
