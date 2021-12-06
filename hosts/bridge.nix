{ pkgs, self, inputs, ... }:
{
  imports = [
    inputs.zeek2nix.nixosModules.zeek
  ];
  environment.systemPackages = [
    pkgs.coreutils
    pkgs.gnugrep
  ];

  services.zeek = {
    enable = true;
    standalone = true;
    interface = "eth0";
    host = "127.0.0.1";
  };
}
