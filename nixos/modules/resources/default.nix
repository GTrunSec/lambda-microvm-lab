{ config
, lib
, pkgs
, ...
}:
let
  dir = ../../../profiles;
  DirNames = builtins.attrNames (builtins.readDir dir);
  machine = (lib.importTOML (dir + "/options.toml")).${config.networking.hostName};
in
{
  options =
    with lib; {
      machine = mkOption {
        default = machine;
        description = "host's options";
      };
    };
}
