{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "sh-pass-git-helper";
  src = fetchFromGitHub {
    owner = "owm111";
    repo = "sh-pass-git-helper";
    rev = "6a6198f31d3be1714bc8eba1917115a969347cb0";
    sha256 = "1y8mmmri004447nrr060akhdvhc1kzmzfyphjd9j6ck1y29ygcs1";
  };
  installPhase = "install -Dvm 755 pass-git-helper $out/bin/pass-git-helper";
}
