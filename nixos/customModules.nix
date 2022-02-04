inputs: with inputs;
{
  nsmModules = [
    zeek2nix.nixosModules.zeek
    vast2nix.nixosModules.vast
    threatbus2nix.nixosModules.threatbus
    threatbus2nix.nixosModules.threatbus-vast
  ];
  sopsTemplate = [ sops-nix.nixosModules.sops ];
}
