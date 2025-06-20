# Waybar Configuration

This is a custom **Waybar** configuration for use with the **Hyprland** Wayland compositor. It provides system information, workspace control, audio and network status, and integrates reboot/power options with a styled, modular layout.

---

## Preview

![alt text](./preview-waybar.png)

---

## Directory Structure

```bash
~/.config/hypr/waybar/
├── config.jsonc            # Main Waybar configuration file
├── style.css               # Compiled style from SCSS
├── style-base.scss         # Source SCSS style (editable)
├── scripts/
│   ├── launch.sh           # Script to launch Waybar
│   └── toggle_pavucontrol.sh # Script to toggle pavucontrol
```

---

## Installation

### 1. Dependencies

Make sure the following are installed:

* `waybar`
* `jq`
* `pavucontrol`
* `lm_sensors`
* `hyprland`
* `wlogout`
* `blueman` *(optional)*
* `grim`, `slurp` *(for screenshots)*
* `swww` *(for wallpaper)*

Install them via your package manager (e.g., `pacman`, `yay`, `paru`, etc.)

```bash
sudo pacman -S waybar jq pavucontrol lm_sensors wlogout blueman grim slurp swww
```

### 2. Enable temperature sensors

```bash
sudo sensors-detect
```

---

## Autostart Configuration in Hyprland

In your Hyprland config file (`~/.config/hypr/hyprland.conf`), add the following:

```ini
# Waybar and related services
exec-once = ~/.config/hypr/waybar/scripts/launch.sh
```

---

## Styling

* The style is written in SCSS and compiled to `style.css`.
* Source file: `~/.config/hypr/waybar/style-base.scss`

> 💡 To change the look, **edit `style-base.scss`** and recompile to `style.css`.

---

## Custom Keybindings (from `hyprland.conf`)

Some relevant bindings that affect Waybar:

```ini
bind = $mainMod SHIFT, B, exec, ~/.config/hypr/waybar/scripts/launch.sh
```

---

## ✅ Tips

* If Waybar doesn’t start, run the launch script manually to check for errors.
* Use `journalctl -xe` for deeper debugging if necessary.
* Ensure `wlogout`, and `lm_sensors` work correctly before using Waybar modules dependent on them.
