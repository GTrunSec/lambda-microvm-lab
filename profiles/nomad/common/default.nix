{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nomad-driver.nixosModules.nix-driver-nomad
  ];
}
