# Cooldown & DoT Tracking

Tracking spell cooldowns and damage‑over‑time (DoT) effects is critical for optimising rotations and maximising uptime.  While Blizzard’s **Cooldown Manager** was introduced in patch 11.1.5 and will be expanded in 11.2.5/11.2.7 with spell selection, reordering, bar/icon toggling and pandemic indicators【805652344164862†L29-L43】, these features are still limited in 11.2.  This document outlines how to build a robust, standalone system for cooldown and DoT tracking that can later integrate with Blizzard’s improvements.

## Design Goals

* **Self‑contained:** Do not rely on heavy external addons (e.g., WeakAuras).  Instead, implement timers in Lua using Blizzard’s event API.
* **Flexible:** Allow players to customise which spells are tracked, the order they appear, whether they are shown as icons or bars and where they are positioned.
* **Clear pandemic indicators:** Visually indicate when a DoT is within its pandemic window—the final 30% of its duration—so the player knows when to refresh without loss【250441765295417†L147-L151】.
* **Future‑proof:** Design the system to integrate easily with the improved Cooldown Manager when it allows ability selection, reordering, icon toggles and profiles【805652344164862†L29-L43】【250441765295417†L161-L178】.

## Core Components

### 1. Spell List & Configuration

Create a Lua table listing spells to track.  Each entry should include:

| Field | Description |
|------|-------------|
| `spellID` | The numeric spell ID. |
| `name` | A readable name (optional, can be retrieved via `GetSpellInfo`). |
| `type` | Either `cooldown` or `dot`. |
| `pandemic` | Boolean indicating whether to show pandemic highlights (for DoTs). |
| `priority` | A numeric value used to sort timers (lower numbers appear first). |
| `display` | `"bar"` or `"icon"`; whether the timer is a bar or an icon. |
| `enabled` | Whether the spell is currently shown. |

Provide an interface (either a simple table file or an in‑game options panel) for players to enable/disable spells and change their order.  The upcoming Cooldown Manager update will allow drag‑and‑drop reordering and spell searching【805652344164862†L29-L43】; consider implementing a basic version of this via click‑and‑drag rows.

### 2. Event Handling

**Cooldown tracking:**

1. Register for `SPELL_UPDATE_COOLDOWN`.  On this event, iterate through the spell list and call `GetSpellCooldown(spellID)`.  The API returns `start`, `duration` and `enable`.  When `enable == 1` and `duration > 0`, create or update a timer for the spell.
2. Use a frame with an `OnUpdate` script to update timer bars or icon cooldown swipes.  Update at a throttled rate (e.g., 0.1 seconds) to minimise CPU usage.
3. When the cooldown finishes (remaining time ≤ 0), remove or hide the timer.

**DoT tracking:**

1. Register for `UNIT_AURA` for the player’s current target and the player if self‑buffs are tracked.  Use `AuraUtil.FindAuraByName` or `UnitAura` to find the application of tracked DoTs (e.g., **Curse of Agony**, **Shadow Word: Pain**).
2. When a DoT is detected, start a timer bar.  Track the expiration time (`expTime`) and total duration (`duration`).  Update the bar’s value based on the difference between `expTime` and `GetTime()`.
3. When the DoT enters its pandemic window (remaining time ≤ `duration * 0.3`), change the bar colour or border to red and optionally play a sound.  Blizzard’s future Cooldown Manager update will implement pandemic indicators【250441765295417†L147-L151】; replicating this behaviour now provides familiarity.
4. If the DoT is refreshed before the pandemic window (clipping), optionally flash the bar to warn the player that a partial refresh occurred.

### 3. Display System

**Icon timers:**

* For short cooldowns (e.g., interrupts, mobility spells), display icons with a numeric cooldown overlay.  The number counts down in whole or tenths of a second depending on duration.
* Use the central colour palette for the icon border and background.

**Bar timers:**

* For longer cooldowns and DoTs, use bar timers.  Each bar includes the spell icon, name and a progress bar representing remaining time.  Bars align vertically or horizontally based on configuration.
* Sort bars according to the `priority` field so that important cooldowns appear first.  If multiple bars share the same priority, sort by remaining time.
* Provide options to stack bars upwards or downwards from an anchor point; mimic the flexible positioning planned for the future Cooldown Manager【250441765295417†L161-L178】.

**Grouping:**

* Group timers by type if desired (e.g., player cooldowns vs. DoTs vs. special buffs).  You can model this after ShestakUI’s Filger categories【77664884591593†L521-L548】.  Each category may have its own anchor and direction.

### 4. Sound Alerts and Extras

* Offer an option to play a custom sound when a DoT enters its pandemic window or when a critical cooldown (e.g., **Bloodlust**) becomes available.  Blizzard has mentioned adding sound alerts and pings to the improved Cooldown Manager【250441765295417†L161-L178】; implementing this now will prepare users for that behaviour.
* Integrate with the `Raid & Party Cooldown Bars` module so that group cooldowns appear in the same frame as personal timers when appropriate.
* Provide an option to assign key binds to quickly enable or disable all timers (for example, to reduce clutter during casual play).

## Integration with Blizzard’s Cooldown Manager

When the enhanced Cooldown Manager launches, players may prefer to use Blizzard’s version for certain abilities.  To support this, design your tracking system to:

1. **Optionally hide duplicate timers** when Blizzard’s Cooldown Manager is tracking the same ability.  Detect when a spell is present in the Cooldown Manager’s tracking list and avoid duplicating it.
2. **Import/export lists:** Allow import/export of your spell list to/from the Cooldown Manager when the API becomes available.  This ensures players do not need to maintain two separate lists.
3. **Profiles & layouts:** Align your display positioning and profiles with Blizzard’s Edit Mode and profile saving features【250441765295417†L161-L178】.  When the Cooldown Manager supports saving layouts, ensure your module can adopt those anchors.

## Summary

By capturing cooldown and DoT information through Blizzard’s event API and presenting it in configurable bars or icons, you give players precise control over their rotation without relying on heavy third‑party addons.  Modelling the system after ShestakUI’s Filger categories【77664884591593†L521-L548】 and anticipating the upcoming improvements to Blizzard’s Cooldown Manager【805652344164862†L29-L43】【250441765295417†L147-L151】 ensures that the UI remains relevant and flexible as the game evolves.