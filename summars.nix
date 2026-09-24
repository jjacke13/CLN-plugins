{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "summars";
  version = "6.2.3";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "summars";
    rev = "v6.2.3";
    hash = "sha256-CnRD/t5LUbYK3jgrhdkkk/RyxgpA+8Oap9Vz22gq3bY=";
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
