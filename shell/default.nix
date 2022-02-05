{ self
, inputs
, pkgs
, ...
}:
{ exportedModules = [ ./commands.toml ]; }
