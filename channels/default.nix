{
  self,
  inputs,
}: {
  nixos = import ./nixos.nix {inherit self inputs;};
  nixos-latest = import ./nixos-latest.nix {inherit self inputs;};
  # nixpkgs_21_05 = import ./nixpkgs_21_05.nix { inherit self inputs; };
}
