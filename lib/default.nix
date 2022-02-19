{lib}:
lib.makeExtensible (
  self: {
    getHostInfo = dirName: rec {
      name = "/tmp/" + (builtins.baseNameOf dirName);
      hypervisor = builtins.elemAt (builtins.split "_" (builtins.baseNameOf dirName)) 2;
      id = builtins.elemAt (builtins.split "_" (builtins.baseNameOf dirName)) 4;
      mac = toString ((lib.toInt id) + 1);
    };
  }
)
