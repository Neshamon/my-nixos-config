{ config, pkgs, lib, ... }:

with lib;
	let cfg = config.modules.programs.bottom;
in
{
	options.modules.programs.bottom = {
		enable = mkEnableOption "bottom";
	};

	config = mkIf cfg.enable {
		home.file.".config/bottom/bottom.toml".text = ''
		[flags]
		dot_marker = true
		group_processes = true
		left_legend = true

		[colors]
		table_header_color="LightBlue"
		widget_title_color="Gray"
		avg_cpu_color="Red"
		cpu_core_colors=["LightMagenta", "LightYellow", "LightCyan", "LightGreen", "LightBlue", "LightRed", "Cyan", "Green", "Blue", "Red"]
		ram_color="LightMagenta"
		swap_color="LightYellow"
		rx_color="LightCyan"
		tx_color="LightGreen"
		border_color="Gray"
		highlighted_border_color="Gray"
		text_color="Gray"
		selected_text_color="Black"
		selected_bg_color="LightBlue"
		graph_color="Gray"


		[[row]]
		 ratio=40
		 [[row.child]]
		 type="cpu"
	 	[[row]]
	 	   ratio=40
	 	   [[row.child]]
	 	     ratio=4
	 	     type="net"
	 	   [[row.child]]
	 	     ratio=4
	 	     [[row.child.child]]
	 	       type="disk"
	 	[[row]]
	 	 ratio=50
	 	 [[row.child]]
	 	   type="mem"
	 	 [[row.child]]
	 	   type="proc"
	 	   default=true
		'';
	};
}
