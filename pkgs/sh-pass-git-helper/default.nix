{ stdenv, fetchFromGitHub, lib, cases ? null }:

with lib;

stdenv.mkDerivation rec {
  name = "sh-pass-git-helper";
  src = fetchFromGitHub {
    owner = "owm111";
    repo = "sh-pass-git-helper";
    rev = "548dd161c32ac40f37db393fd3608cffac8accc2";
    sha256 = "0phx71wm5m74hm8hahx2pbh8c1bfnhl7zml65fjqvykgqim8hf41";
  };
  makeFlags = [ "PREFIX=$(out)" ];
  preBuild = optionalString (cases != null) ''
    cp ${cases} cases.txt
  '';
}
