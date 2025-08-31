{ pkgs
, ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "clnrest";
  version = "0.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "ElementsProject";
    repo = "lightning";
    rev = "v25.05";
    hash = "sha256-XkEeEOpE+tzQ25vzgH6FfE1FNHgwAVdNd9zhMjgxY18=";
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
