{ pkgs, inputs, system }:

pkgs.python3Packages.buildPythonApplication {
  pname = "cln-rebalance-plugin";
  version = "0.1.0";
  format = "other";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "d37793f5b0681c87a3e63ae784ec520484e6646b";
    sha256 = "sha256-niKdcZ3Plu6hO0x2FYOY6QfoIta3HjDblF/6STACjkU=";
  };

  sourceRoot = "source/rebalance";

  propagatedBuildInputs = [
    inputs.self.packages.${system}.pyln-client
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin/
    substituteInPlace $out/bin/rebalance.py \
      --replace-fail "#!/usr/bin/env -S uv run --script" "#!${pkgs.python3}/bin/python3"
    chmod +x $out/bin/rebalance.py
  '';

  doCheck = false;
}
