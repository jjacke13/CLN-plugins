{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "sling";
  version = "4.3.2";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "sling";
    rev = "v4.3.2";
    hash = "sha256-8xDcQlbnffqVhCRhWBBBHv5JMydtfO5ljUANF+pICl0=";
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
