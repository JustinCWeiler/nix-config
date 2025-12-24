{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixos-hardware.url = "github:nixos/nixos-hardware/master";
	};

	outputs = { nixpkgs, nixos-hardware, ... } @ inputs:
	let
		system = "x86_64-linux";
		hostName = "yedevsky";
	in {
		nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [
				#nixos-hardware.nixosModules.framework-16-amd-ai-300-series-nvidia
				./configuration.nix
			];
			specialArgs = {
				inherit hostName;
				inherit inputs;
			};
		};
	};
}
