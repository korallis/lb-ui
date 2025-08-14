# LBUI Roadmap / TODO

Legend: [ ] not started, [~] in progress, [x] done

## High Priority

1) Nameplates
- [ ] Styled plates with health %, threat glow, cast bars, target arrow
- [ ] Up to 4 player debuffs with pandemic emphasis and size boost
- [ ] Quest icons; class resources on relevant targets
- [ ] Scale/spacing/texture options via config
- Touch: `LBUI/modules/nameplates.lua`, `LBUI/config.lua`

2) Auras / DoT & Cooldown Tracking
- [ ] Filger-style categories (player buffs, procs, target debuffs, aura bars, cooldowns)
- [ ] Pandemic highlighting for DoTs; numeric timers and icon modes
- [ ] Per-class/spec spell lists and simple selection/order UI
- Touch: `LBUI/modules/auras.lua`, `LBUI/modules/cooldowns.lua`, `LBUI/config.lua`

3) Mythic+ Panel
- [ ] Keystone level, timer with ahead/on-pace/behind coloring, affix icons
- [ ] Enemy forces % and bosses remaining
- [ ] Integrate party cooldown bars when in Mythic+
- Touch: `LBUI/modules/mythicplus.lua`

4) Party/Raid Cooldown Bars
- [ ] Bars for key defensives/utility/interrupts sorted by remaining time
- [ ] Listen to `UNIT_SPELLCAST_SUCCEEDED` and compute durations
- [ ] Integrate with Mythic+ panel layout
- Touch: `LBUI/modules/cooldowns.lua`

5) Unit Frames
- [ ] Compact player/target/focus with cast bars, ToT, heal prediction
- [ ] Drag/move mode; toggles for elements; performance-safe updates
- Touch: `LBUI/modules/unitframes.lua`, `LBUI/config.lua`

10) In-game Config, Move Mode, Profiles
- [ ] `/lbui config` panel (fonts, colors, scales, module toggles)
- [ ] `/lbui move` drag anchors; lock/unlock
- [ ] Profiles save/load
- Touch: `LBUI/core.lua` (slash routing), `LBUI/config.lua`, new `LBUI/modules/configui.lua`

11) Localization + TOC Modernization
- [ ] Add `Localization/[TextLocale].lua` files and locale loader
- [ ] TOC: `## SavedVariables`, `## SavedVariablesPerCharacter`, `## Category`, `## Group`, addon compartment entries
- [ ] Keep `## Interface` current (Retail 11.2+) and add per-file `[TextLocale]` as needed
- Touch: `LBUI/LBUI.toc`, `LBUI/core.lua`, new `LBUI/Localization/*.lua`

12) Accessibility & Performance
- [ ] Global font scale and high-contrast/color-blind palettes
- [ ] Event-driven updates; throttle timers; minimize `OnUpdate`
- [ ] Optional debug/profiling toggles
- Touch: `LBUI/config.lua`, all modules

## Medium Priority

6) Action Bars
- [ ] Primary bar bottom-center; optional side bars; fade out of combat
- [ ] Cooldown text/charges; scale/spacing sliders; hide empty buttons
- Touch: `LBUI/modules/actionbars.lua`, `LBUI/config.lua`

7) DPS Meter
- [ ] Lightweight window(s) for current/overall DPS/HPS/threat
- [ ] Snap/lock/resize; bookmarks for interrupts/deaths
- [ ] Throttled combat log processing; segment limits; auto reset
- Touch: `LBUI/modules/dpsmeter.lua`

8) Chat & Data Texts
- [ ] Styled chat panels (timestamps, URL copy, quick channel)
- [ ] Data texts: time, gold, FPS/latency, durability with tooltips
- Touch: `LBUI/modules/chat.lua`, `LBUI/modules/datatexts.lua`

9) Minimap & Quest Tracker Styling
- [ ] Square/rounded minimap, coords, integrated tracking/calendar buttons
- [ ] Styled objective tracker; auto-collapse in instances
- Touch: `LBUI/modules/minimap.lua`

13) Documentation & QA
- [ ] Update `README.md` with features, commands, first-run guide
- [ ] Add internal debug mode and lightweight benchmarks
- [ ] Basic test scenarios: solo/leveling, 5-man M+, raid dummy

## Notes
- Focus: minimal, readable, performant; align with Blizzard’s newer UI (e.g., Cooldown Manager) and avoid prohibited automation.
- Ensure no deprecated APIs; keep TOC fields up-to-date; add addon compartment integration.

