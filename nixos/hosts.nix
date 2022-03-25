{
  self,
  inputs,
  customModules,
  ...
}: {
  nomad-tenzir-vast = {
    modules = [
      customModules.nomad
    ];
  };
  nomad-tenzir-opencti = {
    modules = [
      customModules.nomad
    ];
  };
  nomad-airflow = {
    modules = [
      customModules.nomad
    ];
  };
}
