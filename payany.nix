{
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "payany";
  version = "0.2.5";

  src = pkgs.fetchFromGitHub {
    owner = "daywalker90";
    repo = "payany";
    rev = "v0.2.5";
    hash = "sha256-fEFM7NpunZpUawL5Mr6oGfN3xeCcJuo08GhOedNVMks="; 
  };
  
  nativeBuildInputs = with pkgs; [ cargo rustc ];

  buildInputs = with pkgs; [ openssl pkg-config ];

  doCheck = false;

  enableParallelBuilding = true;

}