# Hyprland Liquid Glass Waybar Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Apply the approved floating liquid-glass treatment to the active Waybar and keep the dotfiles template aligned.

**Architecture:** Hyprland provides backdrop blur through a `layerrule` for the `waybar` namespace. Waybar provides the translucent rounded panel, module capsules, margins, border, and shadow through its JSON config and GTK CSS. The live Waybar copy and the versioned dotfiles copy are updated without changing module selection or tooltip readability.

**Tech Stack:** Hyprland 0.56 layer rules, Waybar JSON, GTK CSS, `hyprctl`, `systemctl`/process restart, `grim`.

---

### Task 0: Apply the native liquid-glass app profile

**Files:**
- Modify: `/home/dimas/.dotfiles/hypr/.config/hypr/UserConfigs/UserDecorations.conf:13-110`

- [x] **Step 1: Add the glass rim and rounded geometry**

Set the general and decoration values to:

```ini
border_size = 1
col.active_border = rgba(ffffff44)
col.inactive_border = rgba(ffffff22)

rounding = 18
```

- [x] **Step 2: Enable depth and liquid-glass color modulation**

Set the shadow and blur values to:

```ini
shadow {
  enabled = true
  range = 24
  render_power = 3
  color = rgba(00000055)
  color_inactive = rgba(00000028)
}

blur {
  enabled = true
  size = 10
  passes = 2
  new_optimizations = on
  ignore_opacity = false
  xray = false
  noise = 0.01
  contrast = 1.03
  brightness = 1.02
  vibrancy = 0.15
  vibrancy_darkness = 0.0
}
```

Preserve the existing `active_opacity = 0.86`, `inactive_opacity = 0.78`,
`fullscreen_opacity = 1.0`, and all fullscreen window rules.

- [x] **Step 3: Check the Hyprland diff**

Run:

```bash
git -C /home/dimas/.dotfiles/hypr diff --check -- .config/hypr/UserConfigs/UserDecorations.conf
```

Expected: no output and exit code 0.

### Task 1: Enable Waybar compositor blur

**Files:**
- Modify: `/home/dimas/.dotfiles/hypr/.config/hypr/UserConfigs/WindowRules.conf:207-208`

- [x] **Step 1: Enable only the Waybar layer rules**

Change the currently commented lines to:

```ini
layerrule = blur on, match:namespace waybar
layerrule = ignore_alpha 0.0, match:namespace waybar
```

Leave Rofi, SwayNC, Wlogout, and other layer rules unchanged.

- [x] **Step 2: Check the Hyprland diff**

Run:

```bash
git -C /home/dimas/.dotfiles/hypr diff --check -- .config/hypr/UserConfigs/WindowRules.conf
```

Expected: no output and exit code 0.

### Task 2: Make Waybar a floating panel

**Files:**
- Modify: `/home/dimas/.config/waybar/config:4-8`
- Modify: `/home/dimas/.dotfiles/waybar/.config/waybar/config:4-7`

- [x] **Step 1: Set live Waybar margins**

In the active config, set:

```json
"margin-top": 8,
"margin-left": 12,
"margin-right": 12,
```

Preserve `start_hidden`, module lists, includes, and clock settings.

- [x] **Step 2: Set template Waybar margins**

Apply the same three margin values to the dotfiles template while preserving its existing module and clock choices.

- [x] **Step 3: Validate JSON before restarting Waybar**

Run:

```bash
jq empty /home/dimas/.config/waybar/config
```

Expected: no output and exit code 0. CSS parsing is validated during the controlled Waybar restart in Task 4.

### Task 3: Apply translucent glass CSS

**Files:**
- Modify: `/home/dimas/.config/waybar/style.css:3-115`
- Modify: `/home/dimas/.dotfiles/waybar/.config/waybar/style.css:3-115`

- [x] **Step 1: Make the active CSS background transparent at the widget level**

Use this panel/module treatment while preserving existing colors and module selectors:

```css
* {
  font-family: FantasqueSansMono Nerd Font;
  background-color: transparent;
  font-size: 17px;
  min-height: 0;
}

#waybar {
  background: rgba(30, 30, 46, 0.62);
  color: @text;
  border: 1px solid rgba(205, 214, 244, 0.22);
  border-radius: 18px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.22);
}
```

- [x] **Step 2: Add translucent module capsules**

Set the shared module selector background to:

```css
background-color: rgba(49, 50, 68, 0.42);
border: 1px solid rgba(205, 214, 244, 0.10);
border-radius: 12px;
```

Keep each module’s existing colors, padding, margins, and tooltip rules unless needed to avoid an opaque background.

- [x] **Step 3: Validate CSS changes**

Run:

```bash
git -C /home/dimas/.dotfiles/hypr diff --check -- .config/hypr/UserConfigs/WindowRules.conf
```

Also inspect the live CSS to confirm no global `background-color: @base` remains in the `*` or `#waybar` selectors.

### Task 4: Reload and verify the live desktop

**Files:**
- No source files created.

- [x] **Step 1: Reload Hyprland using the active IPC instance**

Run `hyprctl reload` with the current `HYPRLAND_INSTANCE_SIGNATURE`, then check `hyprctl configerrors`. Expected: `ok` from reload and no config errors.

- [x] **Step 2: Restart Waybar from the active configuration**

Stop the current Waybar process and start `waybar` again, preserving the user session environment. Expected: one running Waybar process and no startup CSS/JSON errors.

- [x] **Step 3: Verify the layer and capture the result**

Run:

```bash
hyprctl layers -j
grim /tmp/hypr-waybar-liquid-glass.png
```

Expected: a `waybar` layer is present, the panel is floating with rounded translucent edges, and the screenshot shows backdrop blur through the panel.
