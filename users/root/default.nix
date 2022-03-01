{
  config,
  pkgs,
  ...
}: {
  users.users.root = {
    password = "";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTQ1V9mjPZY31h55Jl6nl7VBxl6cQgag9+s8kvJSEpZ NixOS-gtrun-14-05-2021"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHehuAtx+QgvUZHtligviw8ECQ0usPBvC+6c4ZPRXV9s host-28-02-2022"
    ];
    #shell = pkgs.zsh;
  };
}
