{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-nip47";
  version = "0.1.4";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "cln-nip47";
    rev = "v0.1.4";
    hash = "sha256-KzJNYJY5yWhqoZL5KVRV6juFhrBdK9UmfBS5KfnUUpg=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}
