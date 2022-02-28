{
  config,
  lib,
  pkgs,
  ...
}:{
  environment.extraInit = ''
    if [[ ! -f "$HOME/.ssh/ed25519.pub" ]]; then
    fi
  '';
}
