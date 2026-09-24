{ pkgs, inputs, system }:

let
  pythonEnv = pkgs.python3.withPackages (ps: [
    inputs.self.packages.${system}.pyln-client
  ]);
in

pkgs.stdenv.mkDerivation {
  pname = "cln-feeadjuster-plugin";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "d37793f5b0681c87a3e63ae784ec520484e6646b";
    sha256 = "sha256-niKdcZ3Plu6hO0x2FYOY6QfoIta3HjDblF/6STACjkU=";
  };

  sourceRoot = "source/feeadjuster";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp *.py $out/bin/
    substituteInPlace $out/bin/feeadjuster.py \
      --replace-fail "#!/usr/bin/env -S uv run --script" "#!${pythonEnv}/bin/python3"
    chmod +x $out/bin/feeadjuster.py
  '';

  doCheck = false;
}
