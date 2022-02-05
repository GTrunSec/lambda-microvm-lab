{ config
, lib
, pkgs
, ...
}:
{ services.zeek = { enable = true; }; }
