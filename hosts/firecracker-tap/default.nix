{ suites
, pkgs
, lib
, system
, self
, ...
}:
let
  name = builtins.baseNameOf ./.;
in
{
  imports = suites."${name}" ++ [ ./microvm.nix ./network.nix ];
  environment.systemPackages = [ pkgs.git ];
}
