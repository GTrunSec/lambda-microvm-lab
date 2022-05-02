channels: final: prev: {
  __dontExport = true;
  # overrides clutter up actual creations
  inherit (channels.nixos-latest) nixUnstable nix-direnv nix-eval-jobs;
  # inherit (channels.nixos-unstbale) elasticsearch7;
}
