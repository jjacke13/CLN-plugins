{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "sling";
  version = "4.2.1";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "sling";
    rev = "v4.2.1";
    hash = "sha256-9xA8SlNBPg0LqkcfkR2LrAed0EId1gOk51pJUkK+BRM=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [ cargo rustc protobuf ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  preBuild = ''
    export PROTOC=${pkgs.protobuf}/bin/protoc
  '';

  doCheck = false;

  enableParallelBuilding = true;

}
