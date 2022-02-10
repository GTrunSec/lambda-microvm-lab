{ config
, lib
, pkgs
, ...
}:
{
  systemd.network = {
    enable = true;
    netdevs.virbr0.netdevConfig = {
      Kind = "bridge";
      Name = "virbr0";
    };
    networks.virbr0 = {
      matchConfig.Name = "virbr0";
      # Hand out IP addresses to MicroVMs.
      # Use `networkctl status virbr0` to see leases.
      networkConfig = {
        DHCPServer = true;
        IPv6SendRA = true;
      };
      addresses = [
        {
          addressConfig.Address = "10.0.0.1/24";
        }
        {
          addressConfig.Address = "fd12:3456:789a::1/64";
        }
      ];
      ipv6Prefixes = [
        {
          ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
        }
      ];
    };
    networks.microvm-eth0 = {
      matchConfig.Name = "vm-*";
      networkConfig.Bridge = "virbr0";
    };
  };
  # Allow DHCP server
  networking.firewall.allowedUDPPorts = [ 67 ];
  # Allow Internet access
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    internalInterfaces = [ "virbr0" ];
  };
}
