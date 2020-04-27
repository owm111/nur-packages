/* Discord is the only binary on my system (besides X) that starts with a capital
   letter. While graphical applications should probably all start with captials,
   almost no program follows this convention.
*/
self: super: {
  discord = super.discord.overrideAttrs
    (old: { preFixup = "mv $out/bin/Discord $out/bin/discord"; });
}
