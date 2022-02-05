{ suites
, pkgs
, lib
, system
, self
, ...
}:
{
  imports = suites.firecracker ++ [ ./microvm.nix ];
  microvm.hypervisor = "firecracker";
  environment.systemPackages = [ pkgs.git ];
}
