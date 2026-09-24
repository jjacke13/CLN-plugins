{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "payany";
  version = "0.4.0";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "payany";
    rev = "v0.4.0";
    hash = "sha256-RrY5lvCXKHmpgnXP2XIzKShF87d+MdopUJG2QgiPDA8=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}
