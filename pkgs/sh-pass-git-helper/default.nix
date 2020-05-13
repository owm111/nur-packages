{ stdenv, fetchFromGitHub, lib, cases ? null }:

with lib;

stdenv.mkDerivation rec {
  name = "sh-pass-git-helper";
  src = fetchFromGitHub {
    owner = "owm111";
    repo = "sh-pass-git-helper";
    rev = "5dca1c572ee79ee979ee61d51e515be9fea196d8";
    sha256 = "1x7xs8ap0rpc8wjclkh7dv4p4fjj6mpm91xn9d86yi926swrsb42";
  };
  makeFlags = [ "PREFIX=$(out)" ];
  preBuild = optionalString (cases != null) ''
    cp ${cases} cases.txt
  '';
}
