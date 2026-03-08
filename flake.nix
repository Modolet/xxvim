{
  description = "xxvim - LazyVim-inspired Neovim distribution built with nixvim and flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      homeModules.default = {
        imports = [
          nixvim.homeModules.nixvim
          ./hm-module.nix
        ];
      };
      homeManagerModules.default = self.homeModules.default;

      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        rec {
          xxvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit pkgs;
            module = import ./config;
          };
          default = xxvim;
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = [ self.packages.${system}.xxvim ];
          };
        }
      );

      checks = forAllSystems (
        system:
        {
          default = self.packages.${system}.xxvim;
        }
      );
    };
}
