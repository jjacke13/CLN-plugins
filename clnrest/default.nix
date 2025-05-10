{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "rest-plugin";
  version = "0.2.0";

  src = ./.;

  cargoHash = "sha256-pzHawrtLyLnjtWpghTj2cs1POv5AHxGYBq3CG2lU6fY=";

  nativeBuildInputs = with pkgs; [ cargo rustc protobuf ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  preBuild = ''
  	export PROTOC=${pkgs.protobuf}/bin/protoc
  '';

  doCheck = false;

}
