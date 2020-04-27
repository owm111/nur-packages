{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.git.sh-pass-git-helper;
  package = pkgs.callPackage ../../pkgs/sh-pass-git-helper { };
in {
  options = {
    programs.git.sh-pass-git-helper = {
      enable = mkEnableOption "sh-pass-git-helper";
      mapping = mkOption {
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
    xdg.configFile."pass-git-helper/mapping.txt".text =
      concatStringsSep "\n" (mapAttrsToList (k: v: "${k} ${v}") cfg.mapping);
  };
}
