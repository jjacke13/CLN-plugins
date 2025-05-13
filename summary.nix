{ pkgs, inputs, system }:

pkgs.python3Packages.buildPythonApplication {
  pname = "cln-summary-plugin";
  version = "1.0";
  format = "other";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "master";
    sha256 = "sha256-n+lnpYXc1b4Sy0CfoUDlV7G9vWfgLh1JbtGhnYPzH6w=";
  };

  sourceRoot = "source/summary";

  propagatedBuildInputs = [
    inputs.self.packages.${system}.pyln-client
    pkgs.python3Packages.requests
    pkgs.python3Packages.packaging
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin/
    chmod +x $out/bin/summary.py
  '';

  doCheck = false;
}
