{ config, lib, pkgs, ... }:

{
  services.airflow = {
    enable = true;
    postgresql = true;
  };
}
