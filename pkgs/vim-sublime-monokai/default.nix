{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  name = "vim-sublime-monokai";
  src = fetchFromGitHub {
    owner = "ErichDonGubler";
    repo = "vim-sublime-monokai";
    rev = "v2.1-scala";
    sha256 = "01wriffz9djlpim4sa4drmhfq8lmyx3f2hhg1xdqfz63lliy5fz8";
  };
}
