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
  imports = [];
  devshell.startup.nodejs-setuphook = pkgs.lib.stringsWithDeps.noDepEntry ''
    export NODE_PATH=${pkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
  '';
}
