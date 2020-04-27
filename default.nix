{ pkgs ? import <nixpkgs> { } }:

rec {
  # Special
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;

  # home-manager
  hmModules = import ./hm-modules;

  # Packages

  # Other's packages
  hacksaw = pkgs.callPackage pkgs/hacksaw { };
  vim-sublime-monokai = pkgs.callPackage pkgs/vim-sublime-monokai { };

  # My packages
  sh-pass-git-helper = pkgs.callPackage pkgs/sh-pass-git-helper { };
  sh-scr = pkgs.callPackage pkgs/sh-scr { inherit hacksaw; };
  sh-todo = pkgs.callPackage pkgs/sh-todo { };
}
