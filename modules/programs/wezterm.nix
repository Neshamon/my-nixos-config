
# Terminal

{  pkgs, ... }:

{
	programs = {
		wezterm = {
			enable = true;
		#	package = pkgs.wezterm.overrideAttrs(o: {
		#		src = pkgs.fetchFromGitHub {
		#			repo = "wezterm";
		#			owner = "wez";
		#			rev = "9559404c3c471951d3ada1116fbcfc32af616a2c";
		#			sha256 = "sha256-SKEab2rZ/wkCiHLvi2cocccw3K1J3q5+9N1a9pmR4QI=";
		#		};
		#	});
			font = rec {
				normal.family = "Source Code Pro";
				size = 10;
			};
		};
	};	
}
