# ghostty/ — terminal rendering config

Symlinked to `~/.config/ghostty/config`. This is a stock Ghostty config file,
but there is **no standalone Ghostty install** — it's read by the Ghostty
embedded inside cmux (see `cmux/CLAUDE.md`). It owns all terminal rendering:
font, theme, transparency (`background-opacity`), blur, cursor, keybinds.

## Current settings

- `font-family = Cascadia Code`, `font-size = 12` — Cascadia's heavier default
  weight reads cleaner at 12pt than Meslo (thin, crowded `mm`) or JetBrains Mono
  (thin). Installed via `brew install --cask font-cascadia-code`.
- `theme = light:Breadog,dark:Breadog` — migrated here from cmux's app-managed
  file so it's the single source of truth (see the gotcha in `cmux/CLAUDE.md`).

## Reload

```fish
cmux reload-config   # applies changes live, no restart
```

## Notes

- **List available fonts** (the cmux-bundled Ghostty CLI):
  ```fish
  /Applications/cmux.app/Contents/Resources/bin/ghostty +list-fonts | grep -i <name>
  ```
  Use the exact family name Ghostty prints, not the file name.
- **Nerd Font glyphs** (prompt icons) work with any primary font: Ghostty
  auto-falls-back to its built-in Nerd Font symbols. No Nerd Font patched face
  required.
- **Too-thin strokes** on a font are fixable without switching via
  `font-thicken = true` (optionally `font-thicken-strength = 0..255`).
- **Reset to cmux's original default**: remove `font-family` and set
  `font-size = 13` (Ghostty's embedded default is JetBrains Mono 13).
