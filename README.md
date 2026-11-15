# dotfiles

My Linux Mint setup: Gruvbox theme, polybar top bar, rofi menus. Two sessions to pick from on the login screen:
**Cinnamon**, and **bspwm** (tiling windows, with picom blurring the menus and terminal). The bar, menus and
scripts are shared by both.

Each folder is a [GNU Stow](https://www.gnu.org/software/stow/) package. The files live here, and links in
`~/.config`, `~/.local/bin` and `~/.local/share/applications` point back to them, so editing a file here changes the live setup.

| Folder | What's in it | Linked to |
|---|---|---|
| `polybar/` | Top bar config (no tray: Wi-Fi and volume are built-in modules), `launch.sh`, login autostart entries (polybar on, NVIDIA Prime tray icon off) | `~/.config/polybar`, `~/.config/autostart/polybar.desktop` |
| `rofi/` | `window-grid.rasi` (grid, colours, size), used by the app menu and window switcher | `~/.config/rofi` |
| `scripts/` | `rofi-menu` (Super+Tab app menu), `rofi-windows` (Alt+Tab window switcher), `wifi-popup` (Wi-Fi drop-down with password box / Switch button, click the Wi-Fi icon on the bar), `polybar-workspaces` (workspace dots), `polybar-autohide` (shows the bar only on workspaces with no windows, sliding it away when one opens), `volume-popup` (drop-down volume slider, click the volume on the bar), `polybar-power-mode` + `power-mode-popup` (power mode icon and its drop-down: Performance / Balanced / Power saver) | `~/.local/bin` |
| `bspwm/` | bspwm session only: `bspwmrc` (window manager, starts everything below), `external-rules` (new windows open on the next empty workspace), `sxhkdrc` (shortcuts, same as Cinnamon's), `picom.conf` (blur, rounded corners), `dunstrc` (notifications), `xsettingsd.conf` (theme for apps), and an autostart entry that keeps picom off in Cinnamon | `~/.config/{bspwm,sxhkd,picom,dunst,xsettingsd}`, `~/.config/autostart/picom.desktop` |
| `applications/` | Launcher overrides: `org.gnome.Terminal.desktop` (the system one has `OnlyShowIn=GNOME;Unity;`, which hides Terminal from the Super+Tab menu in Cinnamon and bspwm) | `~/.local/share/applications` |
| `fontconfig/` | Font smoothing for the OLED monitor: grey edges instead of coloured (sub-pixel) ones, which blur on OLED pixel layouts | `~/.config/fontconfig` |
| `cinnamon/` | Cinnamon settings export: theme, icons, shortcuts, workspaces, panel | loaded with `dconf` (below) |
| `terminal/` | GNOME Terminal profiles (Gruvbox colours) | loaded with `dconf` (below) |

## Everyday use

- Edit files here, then apply: polybar `~/.config/polybar/launch.sh`; rofi and scripts apply next time they open.
- After changing Cinnamon or terminal settings in their apps, save them here: `./export-settings.sh`
- Save a snapshot: `git add -A && git commit -m "what changed"`

## Restoring on a fresh install

```bash
sudo apt install git stow polybar rofi pavucontrol bspwm sxhkd picom dunst feh xsettingsd
git clone <your repo url> ~/dotfiles
cd ~/dotfiles
stow polybar rofi scripts bspwm fontconfig applications
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
- Fonts: DejaVu Sans (interface) and DejaVu Sans Mono (terminal, code) come with Mint
