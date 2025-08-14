# Mythic + and Levelling Considerations

Mythic + dungeons and the levelling experience place different demands on the UI.  This document describes how to tailor the interface for each mode, using the modular design outlined earlier.  The goal is to surface the most relevant information without overwhelming the player.

## Mythic + Dungeons

Mythic + dungeons are timed, challenging encounters where quick decision‑making and awareness of affixes, enemy abilities and party cooldowns are essential.  The UI must help players gauge progress, manage crowd‑control and coordinate defensive abilities.

### Dungeon Timer & Progress

1. **Timer bar:** Display the keystone level, time remaining and threshold times for 1/2/3‑chest completions.  Use a coloured bar (green/yellow/red) to indicate whether the group is ahead or behind.
2. **Enemy forces:** Show the percentage of trash killed and icons for each boss.  Colour completed bosses grey and highlight the next objective.
3. **Affixes:** Show current affix icons with tooltips; include a small reminder of key mechanics (e.g., “Volcanic – dodge erupting puddles”).
4. **Route notes:** Allow players to add notes or import a route plan (similar to *Keystone Guru*).  Keep these notes small and collapsible to maintain a clean look.

### Party & Raid Cooldowns

1. **Integrated cooldown bars:** Merge the raid/party cooldown module (see `modules.md`) into the Mythic + panel.  Track major defensive and offensive cooldowns so players know when tools like **Bloodlust**, **Power Infusion**, **Rebirth** or **Smoke Bomb** are available.
2. **Interrupt rotation:** Provide a sub‑panel listing party interrupts with their cooldowns.  Highlight the next available interrupt.  Casual Friday’s resources recommend OmniCD, a lightweight addon for tracking party cooldowns【228995075923660†L49-L67】; replicate its minimal and accurate display.
3. **Crowd‑control tracker:** Show timers for AoE crowd‑control abilities (e.g., **Leg Sweep**, **Shockwave**, **Binding Shot**) and indicate when they will be ready.  This helps coordinate stuns and avoids overlap.

### Mythic + Specific Auras and Nameplates

1. **Affix debuffs:** For affixes that apply debuffs (e.g., **Grievous**, **Bursting**), show stacks and remaining duration on the player frame.  Colour stack numbers to indicate danger levels.
2. **Enemy spell tracking:** Use the nameplate module to display important casts and the cooldown of mob abilities.  WeakAura packs such as **Spell CDs on Nameplates** provide this information【228995075923660†L108-L110】; implement a simplified version that shows the enemy’s next dangerous ability and its cooldown.
3. **Tank utility:** Highlight enemies fixated on non‑tank players and show tank resource levels (e.g., active mitigation charges) near the party frames.

### Keystones & Rating

1. **Keystone display:** Show the group’s highest keystones and current key level with its affixes.  Provide a quick link to open the built‑in *Adventure Guide* or *Dungeon Journal* for affix descriptions.
2. **Rating summary:** Display the group’s average Mythic + rating and players’ individual ratings.  Link to sites like Raider.io or MythicStats to view more detailed statistics【228995075923660†L135-L139】.  This information helps gauge group experience.
3. **Auto reset features:** When a dungeon starts, automatically reset the DPS meter and aura timers to ensure fresh data.

## Levelling & Casual Play

Levelling requires less precision than Mythic +, so the UI can relax some displays while emphasising quest progression and character growth.

### Simplified Layout

1. **Condensed panels:** Hide or minimise advanced modules such as the raid cooldown tracker and Mythic + panel.  Instead, display a large experience bar with rested XP and level progress.
2. **Quest tracking:** Stylise the objective tracker to match the UI aesthetic.  Show zone objectives, quest counts and a small arrow pointing toward tracked quests.  Provide icons for quest item usage.
3. **Class resources:** Ensure the unit frames clearly display class resources (combo points, holy power, energy), as new players rely on these to learn their rotations.

### Nameplates & Auras

1. **Quest mob markers:** Display exclamation icons on quest mobs’ nameplates【199123363199383†L39-L48】 to help the player identify objectives quickly.
2. **Debuffs & DoTs:** Show DoT timers and pandemic glows on enemies, but allow the player to limit the number of displayed debuffs.  A simplified display reduces information overload.
3. **Scaling:** Increase the size of important elements for low‑level characters (e.g., larger nameplates and bigger debuff icons), as recommended in the Arcane Intellect guide【199123363199383†L175-L179】.

### Supplemental Information

1. **XP per hour & time to level:** Optionally display XP/h metrics and estimated time to level up.  This encourages efficient levelling.
2. **Travel & exploration aids:** Show zone names, waypoints and exploration progress near the minimap.  Provide an indicator when the player has new talent points or unspent dragonriding glyphs.
3. **Combat tips:** For new players, include subtle hints near the action bar (e.g., highlighting procs or reminding the player to apply their DoT).  These can be toggled off once the player is comfortable.

## Adaptive Behaviour

Because the same UI should serve both Mythic + veterans and levelling newcomers, implement adaptive behaviour:

1. **Detection:** Use events to detect when the player enters a Mythic + dungeon (`CHALLENGE_MODE_START`) and switch to the Mythic + layout.  Revert to the levelling layout on completion (`CHALLENGE_MODE_COMPLETED`, `PLAYER_ENTERING_WORLD`).
2. **Profiles:** Provide separate profiles for Mythic +, raiding and levelling.  Blizzard’s upcoming Cooldown Manager enhancements plan to include profile saving【250441765295417†L161-L178】; align with this by allowing players to switch layouts with a command or automatically based on content.
3. **Performance:** Disable modules that are not needed (e.g., Mythic + timer when questing) to reduce CPU usage and memory consumption.  This follows the lightweight philosophy emphasised by KUI Nameplates【199123363199383†L219-L227】.

## Summary

Optimising the UI for Mythic + means surfacing timers, affixes, cooldowns and critical enemy abilities.  Levelling, by contrast, demands clarity and simplicity.  By dynamically adjusting which modules are active and how information is presented, this interface can cater to both high‑end and casual content.  Drawing inspiration from lightweight addons like WarpDeplete and OmniCD, and following the minimal, customisable style of KUI Nameplates【228995075923660†L49-L67】【199123363199383†L39-L51】, ensures that the UI remains both functional and elegant across all forms of gameplay.