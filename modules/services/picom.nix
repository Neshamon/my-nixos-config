# Compositor

{ config, lib, pkgs, ... }:

{
	config = lib.mkIf (config.xsession.enable) {
		services.picom = {
			enable = true;
			fade = true;
			experimentalBackends = true;
			shadow = true;
			backend = "glx";
			vSync = true;
			settings = { 
				shadow-radius = 60;
				shadow-opacity = 0.25;
				shadow-offset-x = -40;
				shadow-offset-y = -40;
				corner-radius = 0;
				rounded-corners-exclude = 
				[
					"window_type = 'dock'"
					"window_type = 'desktop'"
					"class_g = 'awsesome'"
				];
			};
			shadowExclude = [
				"name = 'Notification'"
				"class_g = 'Conky'"
				"class_g = 'Rofi'"
				"class_g = 'Notify-osd'"
				"class_g = 'Cairo-clock'"
				"class_g = 'awesome'"
				"_GTK_FRAME_EXTENTS@:c"
			];
		};
	};
}
