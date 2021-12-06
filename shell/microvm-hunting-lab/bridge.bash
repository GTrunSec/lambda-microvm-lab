#!/usr/bin/env bash
/run/wrappers/bin/sudo nix -Lv run $PRJ_ROOT#qemu-microvm-bridge
