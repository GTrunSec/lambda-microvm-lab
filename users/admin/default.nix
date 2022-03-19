{
  hmUsers,
  config,
  pkgs,
  ...
}: let
  user = builtins.baseNameOf ./.;
in {
  home-manager.users = {inherit (hmUsers) admin;};
  # root passwordFile issue
  security.sudo.wheelNeedsPassword = false;
  users.users."${user}" = {
    uid = 1000;
    password = "";
    description = "For manager";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTQ1V9mjPZY31h55Jl6nl7VBxl6cQgag9+s8kvJSEpZ NixOS-gtrun-14-05-2021"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHehuAtx+QgvUZHtligviw8ECQ0usPBvC+6c4ZPRXV9s host-28-02-2022"
    ];
  };
}
