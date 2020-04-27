{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "sh-todo";
  src = fetchFromGitHub {
    owner = "owm111";
    repo = "sh-todo";
    rev = "461e9e9a0c8886edc4fcd1f55e61fd4db99a1454";
    sha256 = "1fzn9caqmv1z0jci6k7nnhf3zdqs60vgjdfrpi3p0gvl41hh0z40";
  };
  installPhase = "install -Dvm 755 todo $out/bin/todo";
}
