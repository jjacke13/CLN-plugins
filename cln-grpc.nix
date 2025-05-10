{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-grpc-plugin";
  version = "0.4.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-ZS2lu2yX7wHoN2WTe3dnpd2yF6SR7M7Rjc2lsT9A72c=";
  };
  cargoHash = "sha256-dzicHfi0LNQBd2jE0eMatOvzZNpszNy7UkTRThFDisw=";

  nativeBuildInputs = with pkgs; [ cargo rustc protobuf ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  preBuild = ''
    export PROTOC=${pkgs.protobuf}/bin/protoc
  '';

  doCheck = false;

}
