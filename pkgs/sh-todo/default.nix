{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "sh-todo";
  src = fetchFromGitHub {
    owner = "owm111";
    repo = "sh-todo";
    rev = "3eab4dd598e6f3f29abe851531ed25d22fd05b18";
    sha256 = "04p2n3w0dqjfy913aw1vackg28sdhpc8rj13xshfwz2p25bc668z";
  };
  installPhase = "install -Dvm 755 todo $out/bin/todo";
}
