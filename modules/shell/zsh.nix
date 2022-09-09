
# Backup Shell

{ pkgs, ... }:

{
	programs = {
		zsh = {
			enable = true;
			enableAutosuggestions = true;
			enableSyntaxHighlighting = true;
			history.size = 10000;
		};
	};
}
