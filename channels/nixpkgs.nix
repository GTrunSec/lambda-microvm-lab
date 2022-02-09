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
        inherit
          (inputs.vast2nix.packages."${prev.stdenv.hostPlatform.system}")
          vast-release
          ;
      }
    )
  ];
}
