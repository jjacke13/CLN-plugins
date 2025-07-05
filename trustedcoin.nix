{ pkgs }:

pkgs.buildGoModule {
  pname = "trustedcoin";
  version = "0.8.4";

  src = pkgs.fetchFromGitHub {
    owner = "nbd-wtf";
    repo = "trustedcoin";
    rev = "v0.8.4";
    sha256 = "sha256-mROWJEMRuIAcDXtEyin2+MLFplPInOsv5Q7vACNzi80=";
  };

  vendorHash = "sha256-fW+EoNPC0mH8C06Q6GXNwFdzE7oQT+qd+B7hGGml+hc=";
  doCheck = false;

}
