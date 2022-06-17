{
  config,
  lib,
  pkgs,
  ...
}: let
  dir = ../../../profiles/options;
  DirNames = builtins.attrNames (builtins.readDir dir);
  machine = let
    mode = (builtins.elemAt (builtins.split "-" config.networking.hostName) 0) + "-hosts";
  in
    (
      (
        builtins.listToAttrs (
          map (
            conf: {
              value = lib.importTOML (dir + "/${conf}");
              name = lib.removeSuffix ".toml" conf;
            }
          )
          DirNames
        )
      )
    )
    .${mode}
    .${config.networking.hostName};
in {
  options = with lib; {
    machine = mkOption {
      default = machine;
      description = "host's options";
    };
  };
}
