{ config
, lib
, pkgs
, ...
}:
let
  dir = ../../../hosts;
  DirNames = builtins.attrNames (builtins.readDir dir);
  machine =
    (
      { }
      // (
        builtins.listToAttrs (
          map (
            _dir: {
              value = lib.importTOML (dir + "/${_dir}/options.toml");
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
        description = "host's options";
      };
    };
}
