{
  self,
  inputs,
  ...
}: {
  modules = with inputs; [];
  exportedModules = [
    ./devos.nix
    ./commands.toml
    ./lambad-microvm-hunting-lab.nix
  ];
}
