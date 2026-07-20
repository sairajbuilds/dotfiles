{
  description = "Sairaj's macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
  {
    darwinConfigurations."Sairajs-MacBook-Air" =
      nix-darwin.lib.darwinSystem {

        system = "aarch64-darwin";

        modules = [

          ./hosts/macbook/default.nix

          home-manager.darwinModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	   
	    home-manager.backupFileExtension = "backup";

            home-manager.users.sairajsawant =
              import ./home/default.nix;
          }

        ];
      };
  };
}
