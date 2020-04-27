{ hacksaw, shotgun, xclip, writeShellScriptBin }:

let
  hacksawBin = hacksaw + "/bin/hacksaw";
  shotgunBin = shotgun + "/bin/shotgun";
  xclipBin = xclip + "/bin/xclip";
in writeShellScriptBin "scr" ''
  SEL=$(if [ "$1" = -s ]; then ${hacksawBin} -f '-i %i -g %g'; fi)
  FILE="$HOME/Pictures/Screenshots/$(date +%F-%H-%M-%S).png"
  ${shotgunBin} $SEL - | tee "$FILE" | ${xclipBin} -se p -t image/png
''
