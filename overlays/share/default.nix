{ self
, inputs
, ...
}:
with inputs; [
  # (import ../../pkgs/default.nix)
  (
    final: prev: {
      __dontExport = true;
      #lib
      # lib = prev.lib.extend (lfinal: lprev: { our = self.lib; });
      # packages
      inherit (zeek2nix.packages."${prev.system}") zeek-release;
      inherit (vast2nix.packages."${prev.system}") vast-latest;
    }
  )
  ###################
  # Custom Overlays #
  ###################
  ###################
  sops-nix.overlay
]
