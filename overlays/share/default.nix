{
  self,
  inputs,
}:
with inputs; [
  # (import ../../pkgs/default.nix)
  (
    final: prev: {
      __dontExport = true;
      inherit (zeek2nix.packages."${prev.system}") zeek-release;
      inherit (vast2nix.packages."${prev.system}") vast-latest;
    }
  )
  ###################
  # Custom Overlays #
  ###################
  ###################
]
