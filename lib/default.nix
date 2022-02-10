{ lib }:
lib.makeExtensible (
  self: {
    getHostInfo = dirName: {
      name = builtins.elemAt (builtins.split "_" (builtins.baseNameOf dirName)) 2;
      id = builtins.elemAt (builtins.split "_" (builtins.baseNameOf dirName)) 4;
    };
  }
)
