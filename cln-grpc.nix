{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-grpc-plugin";
  version = "0.5.0";

  src = pkgs.fetchFromGitHub {
    owner = "ElementsProject";
    repo = "lightning";
    rev = "v25.12.1";
    hash = "sha256-RgfEEwSqp7qM1CwFFlEUkxjEEAxa3A8kbEuVt4mYJVM=";
  };

  cargoBuildFlags = [ "-p" "cln-grpc-plugin " "--manifest-path" "plugins/grpc-plugin/Cargo.toml" ];

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
