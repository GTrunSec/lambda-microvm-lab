let
  guangtao_nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTQ1V9mjPZY31h55Jl6nl7VBxl6cQgag9+s8kvJSEpZ NixOS-gtrun-14-05-2021";
  guangtao_macos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDI2uDp51HMggnfz4Zn5ky4gb/XVdQiJR7pZyb/LcCLx macOSdeMBP.attlocal.net-gtrun-14-05-2021";
  lambad_microvm_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHehuAtx+QgvUZHtligviw8ECQ0usPBvC+6c4ZPRXV9s host-28-02-2022";

  owner = [guangtao_nixos guangtao_macos];
  machine = [lambad_microvm_host];
in {
  "host/id_ed25519".publicKeys = machine ++ owner;
  "waterwheel".publicKeys = machine ++ owner;
  "waterwheel-hmac".publicKeys = machine ++ owner;
}
