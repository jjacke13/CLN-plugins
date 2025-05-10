{
  description = "Some Core lightning plugins";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs: 

    flake-utils.lib.eachDefaultSystem (system: 
    let 
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        packages = rec {
          cln-grpc = import ./cln-grpc.nix { inherit pkgs; };
          clnrest = import ./clnrest {inherit pkgs; };
          
        };
        
        
      }  
    );
}
