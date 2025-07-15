{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-nip47";
  version = "0.1.3";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "cln-nip47";
    rev = "v0.1.3";
    hash = "sha256-M/H39vOVfd1z7LnJ4xvgpUDvlKh6WL/eKYixrY/qsUo=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}
