# Overview of the Clean & Polished WoW UI

## Vision and Philosophy

The goal of this project is to design a **clean, polished interface** for *World&nbsp;of&nbsp;Warcraft* Retail 11.2 that eliminates clutter while still providing all of the information needed for high‑level play.  Existing UI compilations such as **Tukui** and **ShestakUI** demonstrate how a light weight, modular interface can completely replace the default layout.  ShestakUI’s description stresses that it is an **all‑in‑one UI** built from scratch and that it allows players to customise settings through in‑game slash commands【998033076071695†L98-L107】.  Our design borrows this philosophy: every component—action bars, unit frames, chat, nameplates, auras—will be built as an independent module that follows a shared aesthetic and communicates via simple interfaces.

While the project strives for minimalism, it must also support *mythic +* dungeons and levelling content.  Modern players expect features like **cooldown and debuff tracking**, **party cooldown bars**, **nameplates that convey threat and spell casts**, and a **damage meter**.  Patch 11.2 introduces the *Cooldown Manager* with improvements coming in 11.2.5/11.2.7: players will be able to choose which spells to track, reorder them, toggle bars or icons, search for abilities and track DoTs with pandemic indicators【805652344164862†L29-L43】.  Because these enhancements are not fully implemented in 11.2, our UI will provide its own timers and DoT tracking module modelled after ShestakUI’s *Filger* system【77664884591593†L521-L548】 and the existing raid cooldown tracker【77664884591593†L638-L647】.

### Guiding Principles

1. **Minimalism with polish** – Use unobtrusive textures, consistent typography and a cohesive colour palette.  Avoid gaudy animations; instead rely on subtle highlights, fade‑ins and pandemic glows to draw attention when necessary.
2. **Modularity** – Each functional area (action bars, chat, unit frames, nameplates, DPS meter, auras, minimap, quest tracker) should be a separate Lua module.  Modules communicate via simple events so that they can be swapped or disabled without affecting the rest of the UI.
3. **In‑game configurability** – Players can reposition and scale elements using slash commands similar to ShestakUI’s `/config` and `/moveui` commands【690972457758512†L29-L44】.  Key settings (colours, fonts, textures) should be stored in a central configuration file to enforce consistency.
4. **Performance awareness** – Avoid large frameworks.  ShestakUI and KUI Nameplates both emphasise being lightweight; the Arcane Intellect guide notes that KUI Nameplates are “super lightweight” and use little memory【199123363199383†L219-L227】.  Our UI should follow suit by writing efficient code and reusing Blizzard’s secure templates where possible.

### Layout Overview

The UI layout should be designed around *information grouping* rather than replicating Blizzard’s default positions.  A suggested arrangement is shown below:

- **Central combat area** – Keep the centre of the screen free of UI elements so that enemy casts and ground effects are visible.  Player and target unit frames can be placed just beneath the character to reduce eye movement.
- **Action bars** – Place primary abilities at the bottom centre.  Secondary bars (mounts, consumables) can dock to the right or left.  Use fade‑in effects when out of combat.
- **Auras and cooldown bars** – Timer bars for DoTs, buffs and cooldowns should appear near the unit frames.  Use icons with coloured borders to distinguish friendly buffs from harmful debuffs and display pandemic glows during the final 30% of a DoT【250441765295417†L147-L151】.
- **Nameplates** – Custom nameplates will show health, level, casting bars, threat glows and debuff icons.  The Arcane Intellect article lists features of KUI Nameplates such as custom sizes and fonts, HP percentages, quest icons, target glows, unique colouring for tanks and class resource display【199123363199383†L39-L51】; our plates should incorporate similar features.
- **DPS meter** – A small, movable window (see `dps_meter.md`) summarises damage, healing and threat.  Details! Damage Meter is an example of a feature‑rich, highly configurable meter【642746988870965†L309-L318】; our design will implement a lighter version with custom styling.
- **Mythic + panel** – A dedicated panel shows key timer, dungeon progress, affixes and keystone level.  The Casual Friday resource page recommends addons like WarpDeplete (a minimalistic Mythic+ timer) and OmniCD (party cooldown tracker)【228995075923660†L49-L67】; our panel will draw inspiration from these addons and integrate party cooldown bars into the same frame.

## Implementation Roadmap

The rest of this documentation breaks the UI into a set of modules and describes their responsibilities.  Follow these steps when building the UI:

1. **Define a configuration module** – Provide global options for colours, fonts and textures used across the UI.  Define slash commands to open a config panel and to toggle move/lock mode【690972457758512†L29-L44】.
2. **Implement core modules** – Build action bars, unit frames, chat, minimap and data text panels.  Ensure each module registers for relevant events and exposes a `Load()` function that is called during the `PLAYER_LOGIN` event.
3. **Add advanced modules** – Develop modules for auras (Filger‑style), raid cooldowns, Mythic + tracker, DPS meter and nameplates.  Use the central configuration to style these modules consistently.  When implementing DoT timers, replicate ShestakUI’s Filger categories (player buffs, procs, target debuffs, aura bars, special buffs, PvP auras, cooldowns)【77664884591593†L521-L548】 and the raid cooldown bar sorting by expiration【77664884591593†L638-L647】.
4. **Polish and optimise** – Once all modules are functional, fine‑tune spacing, font sizes and colours.  Test in Mythic + dungeons and during levelling to ensure the layout adapts gracefully to different content.

By following these high‑level guidelines and referencing the module‑specific documents, you can build an interface that feels professional, cohesive and optimised for both progression and casual play.