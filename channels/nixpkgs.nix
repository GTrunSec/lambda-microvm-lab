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
        nomad = inputs.nomad.defaultPackage."${prev.stdenv.hostPlatform.system}";

        inherit
          (inputs.vast2nix.packages."${prev.stdenv.hostPlatform.system}")
          vast-release
          ;
        inherit
          (inputs.microvm.packages."${prev.stdenv.hostPlatform.system}")
          microvm-kernel
          ;
      }
    )
    inputs.sops-nix.overlay
  ];
}
