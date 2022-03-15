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
    inputs.cells."x86_64-linux".common.devshellProfiles.default
  ];
}
