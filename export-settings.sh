#!/bin/sh
# Save Cinnamon and GNOME Terminal settings (stored in dconf, not files) into this folder.
# Run after changing themes, shortcuts, workspaces or terminal colours, then commit.
cd "$(dirname "$0")"
dconf dump /org/cinnamon/ > cinnamon/cinnamon.dconf
dconf dump /org/gnome/terminal/ > terminal/gnome-terminal.dconf
echo "Saved cinnamon/cinnamon.dconf and terminal/gnome-terminal.dconf"
