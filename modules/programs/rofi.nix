
# System Menu

{ config, lib, pkgs, ... }:

let
	inherit (config.lib.formats.rasi) mkLiteral;			# Theme.rasi alternative. Add Theme here
in
{
	programs = {
		rofi = {
			enable = true;
			location = "center";
			theme = {
				"configuration" = {
					modi = mkLiteral "drun";
					font = mkLiteral "Iosevka Nerd Font 10";
					show-icons = true;
					display-drun = mkLiteral "";
					drun-display-format = mkLiteral "{name}";
					sidebar-mode = false;
				};

				"*" = {
					bg = mkLiteral "#263238";
					fg = mkLiteral "#eeffff";
					accent = mkLiteral "#f07178";
					subtle = mkLiteral "#2e3c43";
					background-color = mkLiteral "@bg";
					text-color = mkLiteral "@fg";
					border-color = mkLiteral "@subtle";
				};

				"window" = {
					border = mkLiteral "2px";
					width = mkLiteral "50%";
					padding = mkLiteral "32px";
				};

				"prompt" = {
					background-color = mkLiteral "@subtle";
					enabled = true;
					padding = mkLiteral "0.5% 32px 0% -0.5%";
					font = mkLiteral "Rubik 10";
				};

				"entry" = {
					placeholder = mkLiteral "Search";
					background-color = mkLiteral "@subtle";
					placeholder-color = mkLiteral "@fg";
					expand = true;
					padding = mkLiteral ".15% 0% 0% 0%";
				};

				"inputbar" = {
					children = mkLiteral "[ promt, entry ]";
					background-color = mkLiteral "@subtle";
					expand = false;
					margin = mkLiteral "0%";
					padding = mkLiteral "10px";
				};

				"listview" = {
					colums = 4;
					lines = 3;
					cycle = false;
					dynamic = true;
					layout = mkLiteral "vertical";
				};

				"mainbox" = {
					children = mkLiteral "[ inputbar, listview ]";
					spacing = mkLiteral "2%";
					padding = mkLiteral "2% 1% 2% 1%";
				};

				"element" = {
					orientation = mkLiteral "vertical";
					padding = mkLiteral "2% 0% 2% 0%";
				};

				"element-icon" = {
					size = mkLiteral "48px";
					horizontal-align = mkLiteral "0.5";
				};

				"element-text" = {
					expand = true;
					horizontal-align = mkLiteral "0.5";
					vertical-align = mkLiteral "0.5";
					margin = mkLiteral ".5% .5% -.5% .5%";
				};

				"element-text,
				 element-icon" = {
				 	background-color = mkLiteral "inherit";
				 	text-color = mkLiteral "inhrtit";
				 };

				 "element selected" = {
				 	background-color = mkLiteral "@subtle";
				 };
			};
		};
	};
}
