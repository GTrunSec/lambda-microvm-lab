{ self, inputs, pkgs, ... }:
with pkgs;
let
  reboudBud = inputs.bud self;
in
pkgs.devshell.mkShell {
  imports = [ (pkgs.devshell.importTOML ./commands.toml) ];
  packages = [ ];
  commands = with pkgs; [
    {
      category = "microvm";
      package = reboudBud {
        inherit pkgs inputs;
        name = "microvm-hunting-lab";
        budStdProfile = false;
      };
    }
  ];
}
