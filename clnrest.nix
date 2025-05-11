{
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "clnrest";
  version = "0.1.1";

  src = pkgs.fetchFromGitHub {
    owner = "ElementsProject";
    repo = "lightning";
    rev = "release-v25.02.1";
    hash = "sha256-XWOtWg4ckXepAS4L2GDl+lMO3FsuyCwVNxgfetdg+Lc="; 
  };

  cargoBuildFlags = [ "-p" "clnrest " "--manifest-path" "plugins/rest-plugin/Cargo.toml" ];
  
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