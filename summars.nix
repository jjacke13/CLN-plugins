{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "summars";
  version = "6.2.2";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "summars";
    rev = "v6.2.2";
    hash = "sha256-Krcatpk67BupoqieP/CYDOVJJsdLSBMPN/RpuqgQLE0=";
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
