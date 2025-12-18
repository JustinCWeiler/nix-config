{
	disko.devices = {
		disk = {
			my-disk = {
				device = "/dev/sda";
				type = "disk";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							type = "EF00";
							size = "500M";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [ "umask=0077" ];
							};
						};

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
					};
				};
			};
		};
	};
}
