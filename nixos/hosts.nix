{
  self,
  inputs,
  customModules,
  ...
}: {
  nomad-nixos-1 = {
    modules = [
      customModules.nomad
    ];
  };
}
