{
  inputs,
  pkgs,
  ...
}: {
  modules = with inputs; [];
  exportedModules = [
    ./commands.toml
    ./lambad-microvm-hunting-lab.nix
    inputs.cells.devshellProfiles."x86_64-linux".common
  ];
}
