{ pkgs, inputs, system }:

pkgs.python3Packages.buildPythonApplication {
  pname = "cln-rebalance-plugin";
  version = "1.0";
  format = "other";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "e8a5a19d1f5a34b249a08a3b75b33b9b44780e3c";
    sha256 = "sha256-n+lnpYXc1b4Sy0CfoUDlV7G9vWfgLh1JbtGhnYPzH6w=";
  };

  sourceRoot = "source/rebalance";

  propagatedBuildInputs = [
    inputs.self.packages.${system}.pyln-client
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin/
    chmod +x $out/bin/rebalance.py
  '';

  doCheck = false;
}