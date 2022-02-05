{ suites
, pkgs
, lib
, ...
}:
{
  imports = suites.qemu ++ [ ];
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
  # Host MicroVM settings
  microvm = {
    mem = 8192;
    vcpu = 4;
    socket = "./microvm.sock";
  };
}
