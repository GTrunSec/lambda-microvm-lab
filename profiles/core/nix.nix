{ config, lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    systemFeatures = [ "recursive-nix" "nixos-test" ];
    extraOptions = ''
      experimental-features = nix-command flakes ca-references recursive-nix
    '';
  };
}
