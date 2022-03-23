{
  pkgs,
  extraModulesPath,
  inputs,
  ...
}: {
  packages = [
    pkgs.ragenix
    pkgs.treefmt
    pkgs.treefmt
    pkgs.shfmt
    pkgs.nodePackages.prettier
    pkgs.nodePackages.prettier-plugin-toml
    pkgs.python3Packages.black
  ];
  imports = [inputs.cells."x86_64-linux".update.devshellProfiles.default];
  devshell.startup.nodejs-setuphook = pkgs.lib.stringsWithDeps.noDepEntry ''
    export NODE_PATH=${pkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
  '';
}
