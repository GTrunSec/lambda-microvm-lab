{ config
, lib
, pkgs
, ...
}:
{
  networking = {
    # FIXME: dhcp error
    # 2022-02-05T00:53:03.264950252 [anonymous-instance:main:ERROR:src/devices/src/virtio/net/device.rs:421] Failed to write to tap: Os { code: 5, kind: Other, message: "I/O error" }
    # interfaces.eth0.useDHCP = true;
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
