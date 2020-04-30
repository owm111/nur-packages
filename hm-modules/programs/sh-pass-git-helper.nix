{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.git.sh-pass-git-helper;
  package = (pkgs.callPackage ../../pkgs/sh-pass-git-helper { }).override {
    cases = builtins.toFile "cases.txt" (concatStringsSep "\n"
      (mapAttrsToList (k: v: "${k}) printf '${v}' ;;") cfg.cases));
  };
in {
  options = {
    programs.git.sh-pass-git-helper = {
      enable = mkEnableOption "sh-pass-git-helper";
      cases = mkOption {
        type = with types; attrsOf str;
        default = { };
        example = { "github.com" = "Git/github"; };
        description = "TODO: write this.";
      };
    };
  };
  config = mkIf cfg.enable {
    programs.git.extraConfig.credential.helper =
      "${package}/bin/pass-git-helper";
  };
}
