{
  description = "SnoW NixOS configs";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hm-unstable.url = "github:nix-community/home-manager";
    hm-unstable.inputs.nixpkgs.follows = "nixpkgs";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # Darwin (Mac OS systems)
    darwin.url = "github:lnl7/nix-darwin/nix-darwin-24.11";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Apple Silicon
    apple-silicon-support.url = "github:tpwrules/nixos-apple-silicon";

    # NixCats
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Hyprpanel (AGS)
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # NUR
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Textfox
    textfox.url = "github:adriankarlen/textfox";

    # Cursor theme
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      hm-unstable,
      nixos-wsl,
      darwin,
      stylix,
      nur,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;
      homelabModules = import ./modules/homelab;

      # NixOS configuration entrypoints
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # SERVERS
        serverBase = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/servers/base.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.snow = import ./home-manager/home.nix;
            }
          ];
        };
        serverHomelabFront = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/servers/homelab/front.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.snow = import ./home-manager/home.nix;
            }
          ];
        };
        serverHomelabContainersHost = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/servers/homelab/containers-host.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.snow = import ./home-manager/home.nix;
            }
          ];
        };
        serverHomelabRoon = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/servers/homelab/roon-server.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.snow = import ./home-manager/home.nix;
            }
          ];
        };
        serverTentrackuleHost = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/servers/homelab/tentrackule-host.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.snow = import ./home-manager/home.nix;
            }
          ];
        };

        # WSL
        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.wsl
            ./hosts/wsl/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.snow = import ./home-manager/home.nix;
            }
          ];
        };

        # Asahi Linux
        asahi = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/asahi/configuration.nix
            stylix.nixosModules.stylix
            nur.modules.nixos.default
            hm-unstable.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs outputs;
                  # Desktop computer, so we need GUI stuff.
                  enableGui = true;
                };
                backupFileExtension = ".backn";
              };

              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.snow = import ./home-manager/home.nix;
            }
          ];
        };
      };

      darwinConfigurations = {
        darwin = darwin.lib.darwinSystem {
          specialArgs = { inherit outputs; };
          system = "aarch64-darwin";
          modules = [
            ./hosts/darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "before-nix-backup";

              home-manager.users.snow = import ./home-manager/home.nix;
            }
          ];
        };
      };
    };
}
