{ pkgs, inputs, system }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "cln-backup";
  version = "0.1.0";
  format = "other";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "9bf0b9ac9fe4b2a61cbaef7b39ca3142f74ef821";
    sha256 = "sha256-+c4mRkIO+6UnOeOFrFZyCnkX7NlRPo3Ny9zw/ivjQtg=";
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
