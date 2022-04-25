{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.firewall.allowedUDPPorts = [8200];
  networking.firewall.allowedTCPPorts = [8200];

  services.vault = {
    enable = true;
    address = "0.0.0.0:8200";
    package = pkgs.vault-bin;
  };

  systemd.services.vault = {

    # after = ["create-netrc.service"];

    serviceConfig.ExecStart = lib.mkOverride 10 "${config.services.vault.package}/bin/vault server -dev -dev-no-store-token";

    path = with pkgs; [vault netcat];

    environment = rec {
      VAULT_DEV_ROOT_TOKEN_ID = "root";
      VAULT_DEV_LISTEN_ADDRESS = config.services.vault.address;

      VAULT_ADDR = "http://${VAULT_DEV_LISTEN_ADDRESS}";
      VAULT_TOKEN = VAULT_DEV_ROOT_TOKEN_ID;
    };
  };
}
