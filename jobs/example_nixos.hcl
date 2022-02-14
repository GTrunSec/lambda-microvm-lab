job "microvms" {
  datacenters = ["dc1"]
  type        = "batch"
  namespace   = "default"

  group "bridge" {
    task "firecracker" {
      driver = "nix"

      resources {
        memory = 1000
        cpu = 3000
      }

      config {
        nixos = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.firecracker_example";
      }
    }
  }
}
