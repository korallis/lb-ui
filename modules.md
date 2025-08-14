# Functional Modules

This document describes the individual modules that compose the clean & polished UI.  Each module is responsible for a specific part of the interface.  Modules should be self‑contained Lua files that register for events, create frames and provide `Load()`/`Unload()` functions.  They all share access to a central configuration table (defined in a separate config module) to ensure consistent colours, fonts and textures.

## 1. Action Bars

**Purpose:** Display the player’s abilities in an easily reachable arrangement.

- **Layout:** Place the main bar at the bottom centre with 12 slots; place additional bars to the left/right for consumables, mounts and seldom‑used abilities.
- **Implementation:** Use `ActionButton` templates and secure handlers to remain compatible with Blizzard’s combat restrictions.  Hide empty buttons and fade bars out of combat.  Provide slash commands to toggle bar visibility.
- **Key features:**
  - Show cooldown numbers and charges.  Use Blizzard’s global cooldown sweep and overlay charge counters; enable a text timer for longer cooldowns.
  - Provide options to scale the bars and adjust spacing through the configuration file.
  - Use the central colour palette for borders and highlight textures.

## 2. Unit Frames

**Purpose:** Present player, target, focus and party information.  Unit frames should be compact and positioned near the centre so the player can keep combat in view.

- **Design:** Adopt a minimalist style with flat textures, crisp borders and large fonts.  Use class colours for player health and reaction colours for targets.
- **Elements:** Include health and power bars, cast bars, name text, level indicator, raid icons, buffs/debuffs and heal‑prediction overlays.  A separate target‑of‑target frame should be available.
- **Events:** Register for `UNIT_HEALTH`, `UNIT_POWER_UPDATE`, `UNIT_AURA`, `UNIT_SPELLCAST_START/STOP` and `PLAYER_TARGET_CHANGED` to update frames.  Use `UNIT_MAXHEALTH` and `UNIT_MAXPOWER` to adjust bar lengths.
- **Configurability:** Allow players to drag frames in move mode and to enable/disable cast bars or raid icons via slash commands.

## 3. Auras and Timers (Filger‑style)

**Purpose:** Track player buffs, procs, target debuffs, DoTs and spell cooldowns in a single, consolidated system.  The Filger module from ShestakUI is a good reference: it splits auras into categories such as **player buffs**, **procs**, **target debuffs**, **aura bars**, **special buffs**, **PvP auras** and **cooldowns**【77664884591593†L521-L548】.

- **Implementation:** Create frames anchored near the unit frames.  Each category has its own direction (e.g., buffs grow left to right, debuffs grow right to left).  For DoTs and debuffs with durations, display a bar with the spell icon, name and remaining time.  For shorter cooldowns, display icons with circular cooldown swipes.
- **DoT pandemic indicator:** When a DoT (e.g., **Curse of Agony** or **Shadow Word: Pain**) enters its pandemic window (the final 30% of its duration), highlight its bar with a red border and an optional glow.  The Blizzard roadmap notes that future updates to the Cooldown Manager will provide pandemic indicators and big defensive tracking【250441765295417†L147-L151】; implement these features now to future‑proof the UI.
- **Cooldown tracking:** For major abilities, show icons with numeric cooldown text.  Allow the player to choose which abilities appear and order them manually; this mirrors the upcoming ability selection and drag‑and‑drop ordering planned for the built‑in Cooldown Manager【805652344164862†L29-L43】.
- **Configuration:** Provide a file listing spells to track per class/spec.  This file should be easy to edit so that players can add or remove spells.

## 4. Raid & Party Cooldown Bars

**Purpose:** Show the remaining cooldowns of important party or raid abilities (e.g., **Bloodlust**, **Battle Res**, defensive cooldowns, interrupts).  ShestakUI includes a raid cooldown tracker that displays bars sorted by expiration time【77664884591593†L638-L647】.

- **Implementation:** Use a scrollable frame anchored at the left side of the screen.  Each bar includes the spell name, the unit who used it and the remaining time.  Bars should sort automatically based on time left.
- **Event handling:** Listen for `UNIT_SPELLCAST_SUCCEEDED` events from party/raid members.  Use `GetSpellCooldown` to determine the duration and start time.  Remove bars when the cooldown completes.
- **Integrate with Mythic+ panel:** In Mythic + dungeons, merge these bars with the Mythic + timer panel (see below) to reduce clutter.

## 5. Nameplates

**Purpose:** Replace default nameplates with custom plates that provide more information and better styling.  The Arcane Intellect spotlight on KUI Nameplates highlights features such as **custom sizes, fonts and colours; HP percentages; quest exclamation icons; target arrows; unique colouring for tanks; class resources on plates; and plugin support**【199123363199383†L39-L51】.  It also describes useful tweaks like stacking nameplates for multiple enemies【199123363199383†L130-L133】 and increasing debuff icon sizes【199123363199383†L175-L179】.

- **Design:** Use flat textures, a thin border and a slightly larger height than the default plates.  Provide a coloured glow around the health bar to indicate aggro (green for secure threat, yellow for insecure, red for losing/gained).  Add a small arrow above the target plate to quickly identify the current target【199123363199383†L134-L144】.
- **Components:**
  - **Health bar** with health percentage text; use class colours for friendly players and reaction colours for NPCs.
  - **Cast bar** to show enemy spell casts and interrupts.  Bars should flash when an interruptible cast begins.
  - **Name and level text**; optionally hide level for trivial enemies.
  - **Debuff icons** – up to 4 icons showing player‑applied debuffs.  Increase icon size for pandemic‑range DoTs【199123363199383†L175-L179】.
  - **Quest icons** – show an exclamation mark next to enemies that are part of active quests【199123363199383†L39-L48】.
  - **Class resource display** – show combo points, holy power or runes on the relevant plates【199123363199383†L49-L51】.
- **Configuration:** Provide options to adjust scale and spacing, toggle target arrows, change bar textures/animations【199123363199383†L146-L150】, set custom target colours【199123363199383†L152-L162】, change target plate size【199123363199383†L166-L171】, show health text【199123363199383†L185-L194】 and enable line‑of‑sight fading【199123363199383†L208-L215】.
- **Performance:** KUI Nameplates are praised for being lightweight【199123363199383†L219-L227】; ensure your implementation uses efficient updating (e.g., `OnUpdate` loops only when necessary).

## 6. DPS Meter

**Purpose:** Provide players with feedback on their damage, healing and threat without requiring a bulky external addon.  Details! Damage Meter is widely used because it is highly configurable, parses combat logs into easy‑to‑read charts and is compatible with other addons like WeakAuras and Plater【642746988870965†L309-L318】.  Use it as inspiration while building a lightweight meter that matches the UI aesthetic.

- **Core features:**
  - **Damage and healing tracking** – parse combat events to accumulate DPS/HPS and display them in descending order.
  - **Threat/aggro display** – show threat percentages for tanks and DPS to help manage aggro.
  - **Flexible windows** – allow the player to open multiple windows (e.g., one for current fight, one for overall) and snap them together【642746988870965†L396-L403】.  Add controls for lock/unlock, resize and stretching of windows【642746988870965†L396-L410】.
  - **Bookmarks or displays** – provide quick toggles to switch between data types (damage, healing, interrupts, deaths).  Use right‑click menus similar to Details to change the displayed metric【642746988870965†L409-L431】.
- **Optimisation:** Process combat events in a throttled manner to avoid frame drops.  Provide options to limit the number of stored segments and auto‑reset on boss pull.
- **Integration:** Support data exports (e.g., copy to clipboard) for logs.  Accept data feed from future modules, such as the Mythic + panel.

## 7. Mythic + & Levelling Panel

**Purpose:** Display dungeon progress, key timer, affixes, party cooldowns and leveling progress in a unified panel.  The Casual Friday resources page recommends addons like **WarpDeplete** (accurate and customisable Mythic+ timer) and **OmniCD** (lightweight party cooldown tracker)【228995075923660†L49-L67】.  Our panel will integrate these capabilities directly.

- **Dungeon timer:** Show the keystone level, affixes and a bar representing time remaining.  Use colour cues (green/yellow/red) to indicate ahead/on pace/behind.  Provide icons for the current affixes.
- **Enemy forces tracking:** Display percent complete and a list of bosses remaining.  Update in real time using scenario data.
- **Party cooldowns:** Integrate the raid cooldown bars (Module 4) into this panel when in Mythic + to conserve space.  Show interrupts, defensives and utility spells with remaining times【228995075923660†L49-L67】.
- **Levelling mode:** When not in dungeons, repurpose this panel to show XP bar, rested bonus, current zone objectives and quest tracker.  Provide simple toggles to hide or condense this information.

## 8. Chat and Data Text Panels

**Purpose:** Present chat messages, time, gold, bag slots and other data in a consistent format.

- **Chat:** Embed Blizzard’s chat frames into styled panels.  Add features such as timestamp colouring, URL copy and quick channel switches.  Provide an edit box that hides when not in use.
- **Data texts:** Create small panels anchored to the minimap or action bars that show time, frames per second, latency, durability and gold.  Use tooltips to reveal more detailed information.

## 9. Minimap & Quest Tracker

**Purpose:** Replace the default minimap and quest tracker with more compact versions that integrate with the UI aesthetic.

- **Minimap:** Use a square or rounded‑corner minimap with minimal border and coordinates display.  Add buttons for tracking and calendar integrated into the border.  Hide zone text until moused over.
- **Quest tracker:** Style the objective tracker with the same fonts and colours.  Collapse automatically in raids/dungeons or when the Mythic + panel is active.

## 10. Configuration and Slash Commands

Provide a central place for storing settings such as colours, fonts, textures and module toggles.  Implement slash commands like `/ui config` to open a configuration window and `/ui move` to enable a move/lock mode for dragging frames around.  ShestakUI uses commands such as `/config` and `/moveui`【690972457758512†L29-L44】; adopt a similar pattern.  Support profile saving, which is planned for the built‑in Cooldown Manager update【250441765295417†L161-L178】.

## Summary

Each module described above should be implemented with minimal dependencies and a focus on performance.  Use Blizzard’s improved Cooldown Manager as inspiration for ability selection and DoT tracking【805652344164862†L29-L43】【250441765295417†L147-L151】.  When integrated together, these modules will form a cohesive, polished UI suitable for both Mythic + pushing and casual leveling.