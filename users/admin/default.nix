{ hmUsers
, config
, pkgs
, ...
}:
let
  user = builtins.baseNameOf ./.;
in
{
  # home-manager.users = { inherit (hmUsers) admin; };
  # root passwordFile issue
  security.sudo.wheelNeedsPassword = false;
  users.users."${user}" = {
    uid = 1000;
    password = "";
    description = "For manager";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
}
