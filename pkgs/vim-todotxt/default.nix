{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  name = "vim-todotxt";
  src = fetchFromGitHub {
    owner = "owm111";
    repo = "vim-todotxt";
    rev = "d1db785123bbd04d0981c1c44f6b24c253b163d9";
    sha256 = "1pa54c07zbfjc3kz3fvrgrknyqrddbi8dw5yrijvrbx66dli47pv";
  };
}
