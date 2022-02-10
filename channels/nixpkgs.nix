{ self
, inputs
, ...
}:
{
  imports = [ (inputs.digga.lib.importOverlays ../overlays/nixpkgs) ];
  overlays = [
    (
      final: prev: {
        __dontExport = true;
        lib = prev.lib.extend (lfinal: lprev: { our = self.lib; });
        inherit
          (inputs.vast2nix.packages."${prev.stdenv.hostPlatform.system}")
          vast-release
          ;
      }
    )
  ];
}
