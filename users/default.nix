{
  self,
  inputs,
  ...
}: {
  #################################
  # home-manager Users's Profiles #
  #################################
  imports = [(inputs.digga.lib.importExportableModules ./modules)];
  modules = [];
  importables = rec {
    profiles = inputs.digga.lib.rakeLeaves ./profiles;
    suites = with profiles; rec {base = [];};
  };
  users = {
    admin = {suites, ...}: {
      imports = suites.base;
      home.enableNixpkgsReleaseCheck = false;
    };
  };
}
