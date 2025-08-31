{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-grpc-plugin";
  version = "0.4.0";

  src = pkgs.fetchFromGitHub {
    owner = "ElementsProject";
    repo = "lightning";
    rev = "v25.05";
    hash = "sha256-XkEeEOpE+tzQ25vzgH6FfE1FNHgwAVdNd9zhMjgxY18=";
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
