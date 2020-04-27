{ rustPlatform, fetchFromGitHub, buildPackages, xorg }:

# nixromancers thus nur does not work. The hases are wrong. This version is also more recent.
rustPlatform.buildRustPackage rec {
  pname = "hacksaw-unstable";
  version = "2020-03-29";

  src = fetchFromGitHub {
    owner = "neXromancers";
    repo = "hacksaw";
    rev =
      "07787277e795b032e60e863967affbfc348f315b"; # This is the most recent revision that compiles for me.
    sha256 = "0zh9ygw1ks8pxghkjl97ybikyx65r0d0628czz0s1rrgbkak30s1";
  };

  cargoSha256 = "1qfnmf3cmam20z5xvmxivcgwm1di6k2z2zba140xcwvvr7gmfzi1";

  nativeBuildInputs = [ buildPackages.pkgconfig buildPackages.python3 ];
  buildInputs = [ xorg.libX11 xorg.libXrandr ];
}
