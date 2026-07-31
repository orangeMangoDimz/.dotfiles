# Hyprland Native Liquid Glass Design

## Goal

Approximate Apple's liquid-glass appearance on normal application windows
using Hyprland's native decoration settings, without changing Waybar, Rofi,
notifications, other layer surfaces, or fullscreen behavior.

## Scope

- Normal application windows receive the glass treatment.
- Fullscreen windows remain fully opaque and blur-free through the existing
  fullscreen rules.
- Existing workspace, floating, animation, keybind, Game Mode, and layer
  behavior remain unchanged.

## Design

Update `UserConfigs/UserDecorations.conf` with:

- `rounding = 18` and a one-pixel border.
- Translucent active/inactive border colors for a subtle glass rim.
- Active/inactive opacity of `0.86`/`0.78`.
- Blur enabled with `size = 10`, `passes = 2`, optimized rendering, low noise,
  slightly increased contrast/brightness, and moderate vibrancy.
- Soft shadows enabled with a low-alpha color for depth.

Keep the current `fullscreen_opacity = 1.0` and the explicit fullscreen
`force_rgbx`, `opaque`, full-opacity, and `no_blur` rules in
`UserConfigs/WindowRules.conf`.

## Alternatives considered

1. Keep the current native moderate glass: lowest change and GPU cost, but no
   rounded glass rim or depth cues.
2. Native liquid glass tuning: recommended balance using only existing
   Hyprland settings and no added dependencies.
3. Custom shader or third-party plugin: could add optical/refraction effects,
   but is harder to scope per-window and adds compatibility/performance risk.

## Validation

- Check the edited config for whitespace and syntax issues.
- Reload the active Hyprland instance and confirm no config errors.
- Query opacity, blur, rounding, border, and shadow options at runtime.
- Capture the live desktop to confirm the normal-window glass effect visually.
