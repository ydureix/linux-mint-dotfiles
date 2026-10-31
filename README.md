# dotfiles

My Linux Mint (Cinnamon) setup: Gruvbox theme, polybar top bar, rofi menus.

Each folder is a [GNU Stow](https://www.gnu.org/software/stow/) package. The files live here, and links in
`~/.config` and `~/.local/bin` point back to them, so editing a file here changes the live setup.

| Folder | What's in it | Linked to |
|---|---|---|
| `polybar/` | Top bar config (no tray: Wi-Fi and volume are built-in modules), `launch.sh`, login autostart entries (polybar on, NVIDIA Prime tray icon off) | `~/.config/polybar`, `~/.config/autostart/polybar.desktop` |
| `rofi/` | `window-grid.rasi` (grid, colours, size) and `rofi-menu.rasi` (power buttons) | `~/.config/rofi` |
| `scripts/` | `rofi-menu` (Super+Tab app menu with Log out / Sleep / Power off), `rofi-windows` (Alt+Tab window switcher), `rofi-wifi` (Wi-Fi drop-down, click the Wi-Fi icon on the bar), `polybar-workspaces` (workspace dots), `volume-popup` (drop-down volume slider, click the volume on the bar) | `~/.local/bin` |
| `cinnamon/` | Cinnamon settings export: theme, icons, shortcuts, workspaces, panel | loaded with `dconf` (below) |
| `terminal/` | GNOME Terminal profiles (Gruvbox colours) | loaded with `dconf` (below) |

## Everyday use

- Edit files here, then apply: polybar `~/.config/polybar/launch.sh`; rofi and scripts apply next time they open.
- After changing Cinnamon or terminal settings in their apps, save them here: `./export-settings.sh`
- Save a snapshot: `git add -A && git commit -m "what changed"`

## Restoring on a fresh install

```bash
sudo apt install git stow polybar rofi pavucontrol
git clone <your repo url> ~/dotfiles
cd ~/dotfiles
stow polybar rofi scripts
dconf load /org/cinnamon/ < cinnamon/cinnamon.dconf
dconf load /org/gnome/terminal/ < terminal/gnome-terminal.dconf
```

Themes are installed separately (they're large and come from their own projects):

- GTK theme: [Gruvbox-GTK-Theme](https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme), installed with
  `themes/install.sh -t orange -c dark` (Gruvbox dark hard, the one in use; add `--tweaks soft` for the softer
  variant, or use `-c light` for light)
- Icons: that repo's `icons/Gruvbox_Dark` folder, copied to `~/.icons/Gruvbox-Tan`
  (then `gtk-update-icon-cache -f ~/.icons/Gruvbox-Tan`)
- Cursor: Bibata-Modern-Classic comes with Mint (`mint-cursor-themes`)
- Bar icons (Wi-Fi, volume): Symbols Nerd Font from [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/releases)
  (`NerdFontsSymbolsOnly.tar.xz`), with `SymbolsNerdFont-Regular.ttf` copied to `~/.local/share/fonts`
  (then `fc-cache -f`)
