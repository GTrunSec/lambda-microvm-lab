{ suites
, pkgs
, lib
, ...
}:
let
  name = builtins.baseNameOf ./.;
in
{
  imports = suites.${name} ++ [ ./network.nix ./microvm.nix ];
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
