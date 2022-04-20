{
  config,
  lib,
  pkgs,
  ...
}: {
  age.secrets.waterwheel = {
    file = ../../secrets/waterwheel;
  };
  age.secrets.waterwheel-hmac_secret = {
    file = ../../secrets/waterwheel-hmac;
  };
  services.waterwheel = {
    enable = true;
    database.passwordFile = config.age.secrets.waterwheel.path;
    secrets.hmac_secret = config.age.secrets.waterwheel-hmac_secret.path;
  };

  services.postgresql = let
    password = lib.fileContents config.age.secrets.waterwheel.path;
    in {
    enable = true;
    initialScript = pkgs.writeText "pg-init-script.sql" ''
      CREATE ROLE waterwheel LOGIN PASSWORD 'password';
      CREATE DATABASE waterwheel OWNER waterwheel;
    '';
  };
}
