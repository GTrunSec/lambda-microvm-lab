{ pkgs, lib, budUtils, ... }: {
  bud.cmds = with pkgs; {
    bridge = {
      writer = budUtils.writeBashWithPaths [ nixUnstable git coreutils ];
      synopsis = "bridge";
      help = "run qemu-micro-vm with bridge net";
      script = ./bridge.bash;
      extraScript = '''';
    };
  };
}
