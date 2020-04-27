{ config, lib, pkgs, ... }:

with lib;

let cfg = config.programs.mksh;
in {
  #meta.maintainers = [ maintainers.rycee ];

  options = {
    programs.mksh = {
      enable = mkEnableOption "MirBSD Korn Shell";

      historySize = mkOption {
        type = types.int;
        default = 10000;
        description = "Number of history lines to keep in memory.";
      };

      historyFile = mkOption {
        type = types.str;
        default = "$HOME/.mksh_history";
        description = "Location of the bash history file.";
      };

      shellOptions = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Shell options to set.";
      };

      sessionVariables = mkOption {
        default = { };
        type = types.attrs;
        example = { MAILCHECK = 30; };
        description = ''
          Environment variables that will be set for the Bash session.
        '';
      };

      shellAliases = mkOption {
        default = { };
        type = types.attrsOf types.str;
        example = literalExample ''
          {
            ll = "ls -l";
            ".." = "cd ..";
          }
        '';
        description = ''
          An attribute set that maps aliases (the top level attribute names in
          this option) to command strings or directly to build outputs.
        '';
      };

      profileExtra = mkOption {
        default = "";
        type = types.lines;
        description = ''
          Extra commands that should be run when initializing a login
          shell.
        '';
      };

      mkshrcExtra = mkOption {
        # Hide for now, may want to rename in the future.
        visible = false;
        default = "";
        type = types.lines;
        description = ''
          Extra commands that should be added to
          <filename>~/.mkshrc</filename>.
        '';
      };

      initExtra = mkOption {
        default = "";
        type = types.lines;
        description = ''
          Extra commands that should be run when initializing an
          interactive shell.
        '';
      };
    };
  };

  config = (let
    aliasesStr = concatStringsSep "\n"
      (mapAttrsToList (k: v: "alias ${k}=${escapeShellArg v}")
        cfg.shellAliases);

    shoptsStr = concatStringsSep "\n" (map (v: "set -o ${v}") cfg.shellOptions);

    sessionVarsStr = config.lib.shell.exportAll cfg.sessionVariables;

    historyControlStr = concatStringsSep "\n"
      (mapAttrsToList (n: v: "${n}=${v}") ({
        HISTFILE = ''"${cfg.historyFile}"'';
        HISTSIZE = toString cfg.historySize;
      }));
  in mkIf cfg.enable {
    programs.mksh.mkshrcExtra = ''
      ${historyControlStr}

      ${shoptsStr}

      ${aliasesStr}

      ${cfg.initExtra}
    '';

    home.file.".profile".text = ''
      ${optionalString (!config.programs.bash.enable)
      ''. "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"''}

      # There might be problems with definitions of these in bash! Watch out!
      ${sessionVarsStr}

      ${cfg.profileExtra}
    '';

    home.file.".mkshrc".text = ''
      ${cfg.mkshrcExtra}
    '';

    home.packages = [ pkgs.mksh ];
  });
}

