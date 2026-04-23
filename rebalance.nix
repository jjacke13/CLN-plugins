{ pkgs, inputs, system }:

pkgs.python3Packages.buildPythonApplication {
  pname = "cln-rebalance-plugin";
  version = "1.0";
  format = "other";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "c3a2b4e3609b320d917c5ce97efed115942e5c58";
    sha256 = "sha256-nHl70O93McT3vs9Q0iyRWYX8VUfvvWfp/Mw3M8xjs38=";
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
