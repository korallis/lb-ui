# Clean & Polished WoW UI Design Overview

This documentation set describes how to design a **clean, polished user interface** for World of Warcraft retail **11.2** with minimal add‑ons.  The goal is to build a **Mythic +‑ and leveling‑oriented UI** that:

- Uses a **minimalist layout** similar to Tukui or ShestakUI with consistent fonts, textures and colours.
- Tracks player buffs, debuffs, damage‑over‑time (DoT) spells and spell cooldowns without relying on large third‑party add‑ons.  The built‑in Cooldown Manager introduced in patch 11.1.5 can be leveraged and extended【805652344164862†L29-L43】.
- Incorporates a **DPS meter** and **styled nameplates** similar to KUI Nameplates.
- Adapts to **Mythic +** dungeons and **leveling** by displaying relevant progress (dungeon percent, key timer, affixes) and by simplifying information at lower levels.

The documents in this folder outline design principles, module breakdowns and implementation guidelines for an AI agent tasked with building this UI.  All aesthetic decisions (colours, spacing, typography) should be applied consistently across modules to produce a unified look.

## File Structure

| File | Purpose |
|------|---------|
| `overview.md` | High‑level design goals and layout recommendations. |
| `modules.md` | Breakdown of functional modules (action bars, unit frames, nameplates, DPS meter, etc.) with implementation notes. |
| `aesthetics.md` | Guidelines for colours, fonts, textures and general style. |
| `mythic_plus_and_leveling.md` | Special considerations for Mythic + dungeons and leveling. |
| `dps_meter.md` | Implementation notes for integrating a lightweight DPS meter. |
| `nameplates.md` | Guidelines for building nameplates styled after KUI with aura tracking and threat colouring. |
| `cooldown_and_dot_tracking.md` | Instructions for tracking cooldowns and DoTs using internal code rather than external add‑ons. |

Refer to these documents when constructing each part of the UI.  Remember that patch 11.2.5/11.2.7 will introduce additional customisation options for the Cooldown Manager【805652344164862†L29-L43】; some features may evolve as those updates go live.
