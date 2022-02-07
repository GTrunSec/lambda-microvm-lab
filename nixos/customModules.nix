inputs: with inputs;
{
  nsm = [
    zeek2nix.nixosModules.zeek
    vast2nix.nixosModules.vast
    vast2nix.nixosModules.vast-client
    threatbus2nix.nixosModules.threatbus
    threatbus2nix.nixosModules.threatbus-vast
  ];
  secrets = [ sops-nix.nixosModules.sops ragenix.nixosModules.age ];
}
