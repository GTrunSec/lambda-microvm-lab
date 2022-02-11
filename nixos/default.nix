{ self
, inputs
, channels
, ...
}:
let
  ##################
  # Custom Modules #
  ##################
  customModules = import ./customModules.nix inputs;
in
{
  hostDefaults = import ./hostdDefaults.nix { inherit self inputs channels customModules; };
  ######################################
  # Structured Profiles For Each Host  #
  ######################################
  importables = import ./suites.nix { inherit self inputs; };
  ####################
  # Hosts  Resources #
  ####################
  imports = [ (inputs.digga.lib.importHosts ../hosts) ];

  hosts = import ./hosts.nix { inherit self inputs customModules; };
}
