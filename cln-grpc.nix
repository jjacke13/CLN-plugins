{
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cln-grpc-plugin";
  version = "0.3.0";

  src = pkgs.fetchFromGitHub {
    owner = "ElementsProject";
    repo = "lightning";
    rev = "release-v25.02.1";
    hash = "sha256-XWOtWg4ckXepAS4L2GDl+lMO3FsuyCwVNxgfetdg+Lc="; 
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