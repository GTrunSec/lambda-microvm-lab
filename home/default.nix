{
  self,
  inputs,
  ...
}: {
  imports = [(inputs.digga.lib.importExportableModules ../users/modules)];
  modules = [];
  importables = rec {
    profiles = inputs.digga.lib.rakeLeaves ../users/profiles;
    suites = with profiles; rec {
      base = [direnv git zsh];
    };
  };
  users = {
    darwin = {suites, ...}: {imports = suites.base;};
    admin = {suites, ...}: {imports = suites.base;};
  };
}
