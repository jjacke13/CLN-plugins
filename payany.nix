{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "payany";
  version = "0.3.1";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "payany";
    rev = "v0.3.1";
    hash = "sha256-ASTitthBtbKxUfiCpM/4GtxihQDDMEebP+hnfJJPu3I=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}
