{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-nip47";
  version = "0.1.5";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "cln-nip47";
    rev = "v0.1.5";
    hash = "sha256-kULaO8Ya4/cTn66FSlSFFvxc9N2O775MzPhbpYBo/oI=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}
