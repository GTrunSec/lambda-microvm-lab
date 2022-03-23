{
  self,
  inputs,
  ...
}: {
  imports = [(inputs.digga.lib.importOverlays ../overlays/nixpkgs)];
  overlays = [
    (
      final: prev: {
        __dontExport = true;
        lib = prev.lib.extend (lfinal: lprev: {our = self.lib;});

        nomad-driver = inputs.nomad-driver.defaultPackage."${prev.stdenv.hostPlatform.system}";

        inherit
          (inputs.vast2nix.packages."${prev.stdenv.hostPlatform.system}")
          vast-release
          ;
      }
    )
    inputs.sops-nix.overlay
    inputs.vault-secrets.overlay
    inputs.ragenix.overlay
  ];
}
