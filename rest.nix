{
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "rest-plugin";
  version = "0.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "ElementsProject";
    repo = "lightning";
    rev = "release-v25.02.1";
    hash = ""; 
  };

  sourceRoot = "source/plugins/rest-plugin";

  nativeBuildInputs = with pkgs; [ cargo rustc protobuf ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  preBuild = ''
  	export PROTOC=${pkgs.protobuf}/bin/protoc
  '';

  doCheck = false;

  enableParallelBuilding = true;

}