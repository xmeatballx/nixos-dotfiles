{
  description = "my first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ...}:
  let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in  {
    nixosConfigurations = {
      nixos-main = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
      nixos-wsl = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
        ./wsl-configuration.nix
        nixos-wsl.nixosModules.wsl
      ];   
     };
     nixos-laptop = lib.nixosSystem {
       system = "x86_64-linux";
       modules = [ ./laptop-configuration.nix ];
     };
    };
    homeConfigurations = {
      meatball = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ ./home.nix ];
      };
      wsl = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ ./wsl-home.nix ];
      };
    };
  };
}
