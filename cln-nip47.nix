{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-nip47";
  version = "0.1.7";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "cln-nip47";
    rev = "v0.1.7";
    hash = "sha256-SHYNfG91YlKQ3YI0f0qYovFp6EYU08dNcFBdXGWsD5o=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}
