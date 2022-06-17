inputs: {
  nixos = {
    imports = [(inputs.digga.lib.importOverlays ../overlays/common)];
    overlays = [
      (
        final: prev: {
          __dontExport = true;
          lib = prev.lib.extend (lfinal: lprev: {our = inputs.self.lib;});

          inherit (inputs.nomad-driver.legacyPackages."${prev.system}") nomad-driver-nix;

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
  };
  darwin-nixpkgs = {
    imports = [(inputs.digga.lib.importOverlays ../overlays/common)];
    overlays = [];
  };
  nixos-latest = {};
  nixos-unstable = {};
}
