{
  config,
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nixUnstable;
    systemFeatures = ["recursive-nix" "nixos-test"];
    extraOptions = ''
      experimental-features = recursive-nix
    '';
  };
}
