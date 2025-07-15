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
        packages = {
          cln-grpc = import ./cln-grpc.nix { inherit pkgs; };
          clnrest = import ./clnrest.nix { inherit pkgs; };
          summars = import ./summars.nix { inherit pkgs; };
          payany = import ./payany.nix { inherit pkgs; };
          pyln-client = import ./pyln-client.nix { inherit pkgs; }; #not a plugin, but needed as a python dependency for python plugins
          summary = import ./summary.nix { inherit pkgs; inherit inputs; inherit system; };
          rebalance = import ./rebalance.nix { inherit pkgs; inherit inputs; inherit system; };
          trustedcoin = import ./trustedcoin.nix { inherit pkgs; };
          sauron = import ./sauron.nix { inherit pkgs; inherit inputs; inherit system; };
          backup = import ./backup.nix { inherit pkgs; inherit inputs; inherit system; };
          nwc = import ./cln-nip47.nix { inherit pkgs; };
        };


      }
    );
}
