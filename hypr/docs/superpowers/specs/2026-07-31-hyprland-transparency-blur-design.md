# Hyprland Transparency and Blur Design

## Goal

Give all normal Hyprland application windows a moderate transparent glass effect with background blur, while keeping fullscreen windows fully opaque and unblurred.

## Current state

`hyprland.conf` sources `UserConfigs/UserDecorations.conf` and
`UserConfigs/WindowRules.conf`. The decoration block currently uses full
opacity and disables blur. `WindowRules.conf` also contains global rules that
force every window opaque, fully opaque, and blur-free.

## Design

- Set normal-window opacity to `0.86` when focused and `0.78` when unfocused.
- Set `fullscreen_opacity = 1.0`.
- Enable decoration blur with `size = 8` and `passes = 2`, retaining the
  existing optimized, clear-color settings.
- Remove the global rules that force all windows to opacity `1.0`, `opaque`,
  and `no_blur`.
- Retain explicit fullscreen rules for `force_rgbx`, `opaque`, full opacity,
  and `no_blur`, ensuring fullscreen remains excluded even if the global
  decoration values change later.
- Leave workspace placement, floating behavior, animations, keybinds, and
  the optional Game Mode script unchanged.

## Alternatives considered

1. Light glass (`0.93`/`0.88`, one blur pass): lower GPU cost but likely too
   subtle for the requested effect.
2. Moderate glass (`0.86`/`0.78`, two blur passes): recommended balance of
   visibility, readability, and GPU cost.
3. Strong glass (`0.80`/`0.70`, three blur passes): more dramatic but less
   readable and more expensive.

## Validation

- Validate the edited files for the intended global and fullscreen rules.
- Run Hyprland's config check/reload command if available.
- Confirm normal windows receive opacity and blur, while fullscreen windows
  remain opaque and blur-free.
