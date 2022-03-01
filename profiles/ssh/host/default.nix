{
  config,
  lib,
  pkgs,
  ...
}: {
  age.secrets.snakeoil-ssh = {
    file = ../../../secrets/host/id_ed25519;
    mode = "0600";
    path = "/etc/snailoil-ssh";
  };
  programs.ssh.extraConfig = ''
    UserKnownHostsFile=/dev/null
    StrictHostKeyChecking=no
    IdentityFile ${config.age.secrets.snakeoil-ssh.path}
  '';

  system.activationScripts.agenixRoot.deps = ["installSSHHostKeys"];

  system.activationScripts.installSSHHostKeys.text = ''
    if [[ ! -f "/root/.ssh/ed25519.pub" ]]; then
    mkdir -p /root/.ssh
    cp ${../../../secrets/host/privateKey} /root/.ssh/id_ed25519
    chmod 0600  /root/.ssh/id_ed25519
    fi
  '';
}
