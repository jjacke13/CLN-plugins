{
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "summars";
  version = "5.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "summars";
    rev = "v5.0.0";
    hash = "sha256-ZLosuOuUmsEOLQ9LK9L70QC79eUBbB/5X2DhPuIJddM="; 
  };
  
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
  
  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}