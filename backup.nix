{ pkgs, inputs, system }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "cln-backup";
  version = "0.1.0";
  format = "other";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "c3a2b4e3609b320d917c5ce97efed115942e5c58";
    sha256 = "sha256-nHl70O93McT3vs9Q0iyRWYX8VUfvvWfp/Mw3M8xjs38=";
  };

  sourceRoot = "source/backup";

  nativeBuildInputs = [
    pkgs.python3Packages.poetry-core
  ];

  propagatedBuildInputs = [
    inputs.self.packages.${system}.pyln-client
    pkgs.python3Packages.click
    pkgs.python3Packages.psutil
    pkgs.python3Packages.flask
    pkgs.python3Packages.werkzeug
    pkgs.poetry
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/bin/
    chmod +x $out/bin/backup.py
    chmod +x $out/bin/backup-cli
  '';

  doCheck = false;

}
