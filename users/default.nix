{ self
, inputs
, ...
}:
with inputs;
{
  #################################
  # home-manager Users's Profiles #
  #################################
  imports = [ (digga.lib.importExportableModules ./modules) ];
  modules = [ ];
  importables = rec {
    profiles = digga.lib.rakeLeaves ./profiles;
    suites = with profiles; rec { base = [ ]; };
  };
  users = {
    admin = { suites
    , ...
    }:
    {
      imports = suites.base;
      home.enableNixpkgsReleaseCheck = false;
    };
  };
}
