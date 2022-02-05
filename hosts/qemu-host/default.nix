{ suites
, pkgs
, lib
, system
, self
, ...
}:
{
  imports = suites.qemu-host ++ [ ./network.nix ./microvm.nix ];
  environment.systemPackages = [ pkgs.git ];
  services =
    let
      service =
        if lib.versionAtLeast (lib.versions.majorMinor lib.version) "20.09"
        then "getty"
        else "mingetty";
    in
      {
        "${service}".helpLine = ''
          Log in as "root" with an empty password.
          Type Ctrl-a c to switch to the qemu console
          and `quit` to stop the VM.
        '';
      };
}
