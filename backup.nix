{ pkgs, inputs, system }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "cln-backup";
  version = "0.1.0";
  format = "other";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "e8a5a19d1f5a34b249a08a3b75b33b9b44780e3c";
    sha256 = "sha256-n+lnpYXc1b4Sy0CfoUDlV7G9vWfgLh1JbtGhnYPzH6w=";
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
