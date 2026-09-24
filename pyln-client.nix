{ pkgs }:

let
  coincurve = pkgs.python3Packages.coincurve.overridePythonAttrs (old: {
    pname = "coincurve-cp314-fix";
    version = "22.0.1";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/bd/f9/e9d3c502369933915d3e72d596a1ddf81b3d5ae986f5bd65bc5ada52e6b9/coincurve_cp314_fix-22.0.1.tar.gz";
      hash = "sha256-toOX+QKnO6FatWUvrnEva6hWJeOCAmvipcXmmIRaefQ=";
    };
    patches = [ ];
  });

  pyln-bolt7 = pkgs.python3Packages.buildPythonPackage rec {
    pname = "pyln-bolt7";
    version = "1.0.246";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/35/f1/30b626e7cec279a2f84084898594c8e84537d6d9af9afbe9858f9a6d8e13/pyln_bolt7-1.0.246-py3-none-any.whl";
      sha256 = "1ib3xckjrl2mha7nsg4kazxmhykmyalv0s5h5iv531ywgz18xm2l";
    };
    format = "wheel";
    doCheck = false;
  };

  pyln-proto = pkgs.python3Packages.buildPythonPackage rec {
    pname = "pyln-proto";
    version = "26.6.8";
    format = "wheel";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/09/b6/696fcf9b568d8df00bc2d3f7b8de598f3bc2b8368d0bddeb1f076fb90574/pyln_proto-26.6.8-py3-none-any.whl";
      sha256 = "sha256-s8zT/BYpVWDJCt1Gv27669a9pYMc3cn8XUaVuof29qc=";
    };
    propagatedBuildInputs = with pkgs.python3Packages; [
      base58
      bitstring
      coincurve
      cryptography
      pysocks
    ];
    dontCheckRuntimeDeps = true;
    doCheck = false;
  };

in

pkgs.python3Packages.buildPythonPackage rec {
  pname = "pyln-client";
  version = "26.6.8";
  format = "wheel";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/d7/cd/53967e05a16aa867f017815223127cc89b1b31198effaadd35d3fc609582/pyln_client-26.6.8-py3-none-any.whl";
    sha256 = "sha256-NnWEoyzO5C2zh+e038iZ3IaFysYJJR5An6pOPsuhnmw=";
  };
  propagatedBuildInputs = [
    pyln-proto
    pyln-bolt7
  ];
  doCheck = false;
}
