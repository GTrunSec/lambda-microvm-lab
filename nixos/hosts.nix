{ self
, inputs
, customModules
, ...
}:
{
  example = {
    modules = [
      customModules.nomad
    ];
  };
}
