{ pkgs }:

let
  coincurve-overlay = self: super: {
    coincurve = super.coincurve.overridePythonAttrs (old: {
      version = "20.0.0";
      src = super.fetchPypi {
        pname = "coincurve";
        version = "20.0.0";
        hash = "sha256-hyQZ5AQwAwLpOISba5Khlvq9rWUQYLVZ3DEOUvg5KCk=";
      };
    });
  };

  pkgs' = pkgs.extend coincurve-overlay;

  pyln-bolt7 = pkgs'.python3Packages.buildPythonPackage rec {
    pname = "pyln-bolt7";
    version = "1.0.246";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/35/f1/30b626e7cec279a2f84084898594c8e84537d6d9af9afbe9858f9a6d8e13/pyln_bolt7-1.0.246-py3-none-any.whl";
      sha256 = "1ib3xckjrl2mha7nsg4kazxmhykmyalv0s5h5iv531ywgz18xm2l";
    };
    format = "wheel";
    doCheck = false;
  };

  pyln-proto = pkgs'.python3Packages.buildPythonPackage rec {
    pname = "pyln-proto";
    version = "26.4";
    format = "wheel";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/0b/c9/8a34960e1e9550f87697d1f05208d9cc916c14419f18f2d6013801079fc1/pyln_proto-26.4-py3-none-any.whl";
      sha256 = "sha256-l3ctKFqg0MihVFV3ru+IIeCNWWdvY652DScOGzAVvJ0=";
    };
    propagatedBuildInputs = with pkgs'.python3Packages; [
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

pkgs'.python3Packages.buildPythonPackage rec {
  pname = "pyln-client";
  version = "26.4";
  format = "wheel";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/60/41/f67df5064b4b9d258fb30e96e1d3ca8f0395c7c0098b24091dde6238fb8e/pyln_client-26.4-py3-none-any.whl";
    sha256 = "sha256-1UcOHszMG25G45ZYwQGcYoaMWu1KAgNjUFKAPd7czi4=";
  };
  propagatedBuildInputs = [
    pyln-proto
    pyln-bolt7
  ];
  doCheck = false;
}
