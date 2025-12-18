{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { nixpkgs, ... } @ inputs:
	let
		system = "x86_64-linux";
		hostName = "yedevsky";
	in {
		nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ ./configuration.nix ];
			specialArgs = {
				inherit hostName;
				inherit inputs;
			};
		};
	};
}
