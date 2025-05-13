{ pkgs }:

let 
pyln-bolt7 = pkgs.python3Packages.buildPythonPackage rec {
    pname = "pyln-bolt7";
    version = "1.0.246";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/35/f1/30b626e7cec279a2f84084898594c8e84537d6d9af9afbe9858f9a6d8e13/pyln_bolt7-1.0.246-py3-none-any.whl";
      sha256 = "1ib3xckjrl2mha7nsg4kazxmhykmyalv0s5h5iv531ywgz18xm2l";
    };
    format = "wheel";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [];
};

pyln-proto = pkgs.python3Packages.buildPythonPackage rec {
  pname = "pyln-proto";
  version = "25.2.2";
  format = "wheel";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/41/76/15c9c02811cb4865081ef7b522596309223b62d1126b29bb79c39662457d/pyln_proto-25.2.2-py3-none-any.whl";
    sha256 = "sha256-nal845JqFqAV+DnzMggf0N/pjr9B9TjE5QozO5t0tQk=";
  };
  buildInputs = [];
  propagatedBuildInputs = with pkgs.python3Packages; [
    base58
    bitstring
    coincurve
    cryptography
    pysocks
  ];
  doCheck = false; # Disable tests to match previous derivations
};

in

pkgs.python3Packages.buildPythonPackage rec {
  pname = "pyln-client";
  version = "25.2.2";
  format = "wheel";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/42/8e/9d7f22f0a8c4a3bbaa8a2ce87022855a831d66a5e519f3a6ccfbe36414fd/pyln_client-25.2.2-py3-none-any.whl";
    sha256 = "sha256-SNGHrelElq9ZW/yEnODwq5/AskIBBI5RwYwvKoe8Liw="; 
  };
  buildInputs = [];
  propagatedBuildInputs = [
    pyln-proto
    pyln-bolt7    
  ];
  doCheck = false; # Disable tests to match previous derivations

}