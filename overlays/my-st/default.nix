/* Setup st to my liking.

   - Enable scrollback and the scroll wheel.
   - Seperate bold and bright formatting.
   - Use DejaVu Sans Mono.
   - Use Monokai-like colors.
*/
self: super: {
  st = super.st.override {
    patches = let
      # Patches to fetch.
      scrollback = super.fetchurl {
        url =
          "https://st.suckless.org/patches/scrollback/st-scrollback-0.8.2.diff";
        sha256 = "0rnigxkldl22dwl6b1743dza949w9j4p1akqvdxl74gi5z7fsnlw";
      };
      scrollback-mouse = super.fetchurl {
        url =
          "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.8.2.diff";
        sha256 = "1fm1b3yxk9ww2cz0dfm67l42a986ykih37pf5rkhfp9byr8ac0v1";
      };
      scrollback-mouse-altscreen = super.fetchurl {
        url =
          "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-0.8.diff";
        sha256 = "1ypn7lrrch0mjxavgn7dakgz2hk87vniajad06m7bsyri5h11z5w";
      };
      bold-is-not-bright = super.fetchurl {
        url =
          "https://st.suckless.org/patches/bold-is-not-bright/st-bold-is-not-bright-20190127-3be4cf1.diff";
        sha256 = "1cpap2jz80n90izhq5fdv2cvg29hj6bhhvjxk40zkskwmjn6k49j";
      };

      # Functions to generate patches.
      fontPatch = fontName:
        builtins.toFile "custom-font-patch.diff" ''
          diff --git a/config.def.h b/config.def.h
          index 546edda..67911c7 100644
          --- a/config.def.h
          +++ b/config.def.h
          @@ -5,7 +5,7 @@
            *
            * font: see http://freedesktop.org/software/fontconfig/fontconfig-user.html
            */
          -static char *font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";
          +static char *font = "${fontName}:size=12:antialias=true:autohint=true";
           static int borderpx = 2;

           /*
        '';

      # TODO: improve this and make it actually work.
      colorPatch = { black ? "black", gray ? "gray40", red ? "red3"
        , lRed ? "red", green ? "green3", lGreen ? "green", yellow ? "yellow3"
        , lYellow ? "yellow", blue ? "blue2", lBlue ? "#5c5cff"
        , purple ? "magenta3", lPurple ? "magenta" # purple>magenta
        , cyan ? "cyan3", lCyan ? "cyan", silver ? "gray90", white ? "white" }:
        builtins.toFile "custom-color-patch.diff" ''
          diff --git a/config.def.h b/config.def.h
          index 67911c7..b87c91b 100644
          --- a/config.def.h
          +++ b/config.def.h
          @@ -85,22 +85,22 @@ unsigned int tabspaces = 8;
           /* Terminal colors (16 first used in escape sequence) */
           static const char *colorname[] = {
                  /* 8 normal colors */
          -       "black",
          -       "red3",
          -       "green3",
          -       "yellow3",
          -       "blue2",
          -       "magenta3",
          -       "cyan3",
          -       "gray90",
          +       "${black}",
          +       "${red}",
          +       "${green}",
          +       "${yellow}",
          +       "${blue}",
          +       "${purple}",
          +       "${cyan}",
          +       "${silver}",

                  /* 8 bright colors */
          -       "gray50",
          -       "red",
          -       "green",
          -       "yellow",
          -       "#5c5cff",
          -       "magenta",
          -       "cyan",
          -       "white",
          +       "${gray}",
          +       "${lRed}",
          +       "${lGreen}",
          +       "${lYellow}",
          +       "${lBlue}",
          +       "${lPurple}",
          +       "${lCyan}",
          +       "${white}",
        '';
    in [
      bold-is-not-bright
      ./monokai.diff
      scrollback
      scrollback-mouse
      scrollback-mouse-altscreen
      (fontPatch "DejaVu Sans Mono")
    ];
  };
}
