{ pkgs }:

pkgs.buildGoModule {
  pname = "trustedcoin";
  version = "0.8.6";

  src = pkgs.fetchFromGitHub {
    owner = "nbd-wtf";
    repo = "trustedcoin";
    rev = "v0.8.6";
    sha256 = "sha256-b+Icq/9qMF+Zvh7RuG9RxU8/U07Tl8ymZvNKWsZzatw=";
  };

  vendorHash = "sha256-fW+EoNPC0mH8C06Q6GXNwFdzE7oQT+qd+B7hGGml+hc=";
  doCheck = false;

}
