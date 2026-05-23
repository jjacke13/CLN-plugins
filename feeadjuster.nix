{ pkgs, inputs, system }:

let
  pythonEnv = pkgs.python3.withPackages (ps: [
    inputs.self.packages.${system}.pyln-client
  ]);
in

pkgs.stdenv.mkDerivation {
  pname = "cln-feeadjuster-plugin";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "lightningd";
    repo = "plugins";
    rev = "c3a2b4e3609b320d917c5ce97efed115942e5c58";
    sha256 = "sha256-nHl70O93McT3vs9Q0iyRWYX8VUfvvWfp/Mw3M8xjs38=";
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
