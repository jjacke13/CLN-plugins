{ pkgs }:

pkgs.buildGoModule {
  pname = "trustedcoin";
  version = "0.8.3";

  src = pkgs.fetchFromGitHub {
    owner = "nbd-wtf";
    repo = "trustedcoin";
    rev = "v0.8.3";
    sha256 = "sha256-GGF1PmErDiKHxrq95NQq50ZsdYPRnt+mcg00S9uG7uQ=";
  };

  vendorHash = "sha256-VbfpVgXnAwhUi06Kd8p/CFkx5t+GBg9GhwLeIDX7dc8="; 
  doCheck = false;
  
}
