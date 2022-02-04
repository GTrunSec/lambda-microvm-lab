{ suites
, pkgs
, inputs
, lib
, options
,  ...
}:
{ imports = suites.qemu ++ [  ];

  environment.systemPackages = [
        pkgs.git
      ];
      services = let
        service = if lib.versionAtLeast (lib.versions.majorMinor lib.version) "20.09" then "getty" else "mingetty";
      in {
        ${service}.helpLine = ''
          Log in as "root" with an empty password.
          Type Ctrl-a c to switch to the qemu console
          and `quit` to stop the VM.
        '';
      };
      virtualisation = lib.optionalAttrs (options.virtualisation ? qemu) {
        # larger than the defaults
        memorySize = 8192;
        cores = 12;
        diskSize = 8192;
        # 9P performance optimization that quelches a qemu warning
        msize = 65536;
        # allow building packages
        writableStore = true;
        # # keep the store paths built inside the VM across reboots
        # writableStoreUseTmpfs = false;

        qemu.options = [
          # faster virtio-console
          "-serial null"
          "-device virtio-serial"
          "-chardev stdio,mux=on,id=char0,signal=off"
          "-mon chardev=char0,mode=readline"
          "-device virtconsole,chardev=char0,nr=0"
        ];

        # use virtio's hvc0 as system console
        qemu.consoles = ["tty0" "hvc0"];

        # headless qemu
        graphics = false;
      };
}
