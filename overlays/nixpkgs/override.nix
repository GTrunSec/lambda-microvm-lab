channels: final: prev: {
  __dontExport = true;
  # overrides clutter up actual creations
  inherit (channels.latest) nixUnstable nix-direnv nix-eval-jobs;
  inherit (channels.unstbale) ;
}
