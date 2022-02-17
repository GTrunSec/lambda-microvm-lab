job "microvms" {
  datacenters = ["dc1"]
  type        = "batch"
  namespace   = "default"

  group "nixos" {
    task "1" {
      driver = "raw_exec"

      resources {
        memory = 1000
        cpu = 3000
      }

      config {
        command = "nix"
        args = [
          "develop",
          "-Lv",
          "/home/gtrun/ghq/github.com/GTrunSec/threatbus2nix/devshell",
          "-c",
          "threatbus-example",
        ]
      }
    }
  }
}
