{
  inputs,
  self,
  ...
}: {
  modules = with inputs; [];
  exportedModules = [
    ./commands.toml
    ./lambad-microvm-hunting-lab.nix
    ./sops.toml
  ];
}
