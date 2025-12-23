{
	disko.devices = {
		disk = {
			my-disk = {
				device = "/dev/nvme0n1";
				type = "disk";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							type = "EF00";
							size = "512M";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [ "umask=0077" ];
							};
						};

						luks = {
							size = "100%";
							content = {
								type = "luks";
								name = "crypt";
								settings.allowDiscards = true;
								content = {
									type = "btrfs";
									extraArgs = [ "-f" ];
									subvolumes = {
										"root" = {
											mountpoint = "/";
											mountOptions = [
												"compress=zstd"
												"noatime"
											];
										};
										"home" = {
											mountpoint = "/home";
											mountOptions = [
												"compress=zstd"
												"noatime"
											];
										};
										"swap" = {
											mountpoint = "/.swap";
											swap.swapfile.size = "8G";
										};
									};
								};
							};
						};

						/*
						swap = {
							size = "8G";
							content = {
								type = "swap";
								discardPolicy = "both";
								resumeDevice = true; # resume from hibernation from this device
							};
						};

						root = {
							size = "100%";
							content = {
								type = "btrfs";
								extraArgs = [ "-f" ]; # override existing partition
								mountpoint = "/";
								mountOptions = [
									"compress=zstd"
									"noatime"
								];
							};
						};
						*/
					};
				};
			};
		};
	};
}
