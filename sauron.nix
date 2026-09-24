{ pkgs, inputs, system }:

pkgs.python3Packages.buildPythonApplication {
  pname = "cln-sauron-plugin";
  version = "0.1.0";
  format = "other";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "d37793f5b0681c87a3e63ae784ec520484e6646b";
    sha256 = "sha256-niKdcZ3Plu6hO0x2FYOY6QfoIta3HjDblF/6STACjkU=";
  };

  sourceRoot = "source/archived/sauron";

  propagatedBuildInputs = [
    inputs.self.packages.${system}.pyln-client
    pkgs.python3Packages.requests
    pkgs.python3Packages.pysocks
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/bin/
    substituteInPlace $out/bin/sauron.py \
      --replace-fail "#!/usr/bin/env -S uv run --script" "#!${pkgs.python3}/bin/python3"
    chmod +x $out/bin/sauron.py
  '';

  doCheck = false;
}
