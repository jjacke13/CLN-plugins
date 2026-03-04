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
    version = "25.12.1";
    format = "wheel";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/74/80/19851847ea4be5b64d4f9a5b68ed84e7b82abbb1f9edf62f664d0ded38dc/pyln_proto-25.9-py3-none-any.whl";
      sha256 = "sha256-QZZdlrf+YjI8trL+iVPYLwBKKga6HACfkc1eiZ7VV14=";
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
  version = "25.12.1";
  format = "wheel";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/52/16/5a9436b88a71ec40ded00ee4159b03e37927873698bbf012e8942c13fe18/pyln_client-25.9-py3-none-any.whl";
    sha256 = "sha256-QXjf4it4HPre97iiqmmVmx0F0LUhKaHfarCIBqd44ik=";
  };
  propagatedBuildInputs = [
    pyln-proto
    pyln-bolt7
  ];
  doCheck = false;
}
