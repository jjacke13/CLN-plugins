{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-nip47";
  version = "0.1.9";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "cln-nip47";
    rev = "v0.1.9";
    hash = "sha256-3MkLPBkpFzbyClVejrxWRcn5ibgIdcIbYkCurG5psIU=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}
