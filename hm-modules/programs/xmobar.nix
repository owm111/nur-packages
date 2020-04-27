{ pkgs, lib, config, ... }:

with lib;

let cfg = config.programs.xmobar;
in {
  options = {
    programs.xmobar = {
      enable = mkEnableOption "Xmobar";

      xmobarrc = mkOption {
        type = with types; nullOr path;
        default = null;
        example = literalExample ''
          pkgs.writeFile "xmobarrc" '''
            -- TODO: does this config actually work?
            Config
              { font = "xft:monospace:size=12"
              , template = "%StdinReader%}%time%{%battery%"
              , commands =
                [ Run StdinReader
                , Run Date "%R on %a %b %d" "time" 10
                , Run Battery [ "-t", "<acstatus> <left>" ] 50
                ]
              }
          ''';
        '';
        description = "File to link at <filename>~/.xmobarrc</filename>.";
      };
      # TODO: Haskell configuration.

      package = {
        default = pkgs.haskellPackages.xmobar;
        defaultText = "pkgs.haskellPackages.xmobar";
        description = "The package to use for xmobar.";
      };
    };
  };
  config = mkIf cfg.enable {
    home = {
      packages = [ pkgs.haskellPackages.xmobar ];
      # TODO: maybe merge and add onChange action.
      file.".xmobarrc" = mkIf (cfg.xmobarrc != null) { source = cfg.xmobarrc; };
    };
  };
}
