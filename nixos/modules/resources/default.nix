{ config
, lib
, pkgs
, ...
}:
let
  dir = ../../../profiles/options;
  DirNames = builtins.attrNames (builtins.readDir dir);
  machine =
    (
      { }
      // (
        builtins.listToAttrs (
          map (
            _dir: {
              value = lib.importTOML (dir + "/${_dir}");
              name = lib.removeSuffix ".toml" _dir;
            }
          )
          DirNames
        )
      )
    )
    ."${config.networking.hostName}";
in
{
  options =
    with lib;
    {
      machine = mkOption {
        default = machine;
        description = "hosts username";
      };
    };
}
