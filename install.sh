#!/usr/bin/env bash

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko.nix || exit
mkdir -p /mnt/etc
cp -r . /mnt/etc/nixos
cd /mnt/etc/nixos
nixos-generate-config --root /mnt
nixos-install --root /mnt --flake .#yedevsky || exit
