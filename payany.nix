{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "payany";
  version = "0.3.0";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "payany";
    rev = "v0.3.0";
    hash = "sha256-VOGJ9vQWozI2Izwwnf8ZJUaR5pGQearuiFzN3DPMIZU=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}
