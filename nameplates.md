# Custom Nameplates

Nameplates are one of the most important parts of a clean and functional UI.  They convey critical information—health, threat, casts, debuffs—directly above enemies and allies.  This guide explains how to build nameplates styled after **KUI Nameplates**, using features highlighted in the Arcane Intellect spotlight【199123363199383†L39-L51】 and adding our own improvements.

## Core Features from KUI Nameplates

The KUI guide emphasises several features that improve readability and gameplay:

1. **Custom sizes, fonts and colours**【199123363199383†L39-L48】 – Players can adjust the width, height, font and colour scheme of nameplates.
2. **Health percentages** – Display the HP % alongside or inside the health bar【199123363199383†L45-L48】.
3. **Quest exclamation icons** – Show an exclamation mark next to quest mobs, making them easy to spot while levelling【199123363199383†L39-L48】.
4. **Target arrows and glows** – A target arrow helps identify the current target, and a coloured glow differentiates targeted nameplates【199123363199383†L134-L144】.
5. **Unique tank colouring** – Tanks can colour plates differently to highlight threat situations【199123363199383†L49-L51】.
6. **Class resources on plates** – Combo points, holy power or runes appear above the plate【199123363199383†L49-L51】.
7. **Plugins and custom scripts** – Add‑ons like **KuiNameplates Target Helper** allow custom colouring for named mobs【199123363199383†L152-L162】; this extends the base addon’s functionality.
8. **Lightweight implementation** – KUI Nameplates are praised for using the least memory and CPU among popular nameplate addons【199123363199383†L219-L227】.

## Layout & Design

### Health Bar

* Use a flat texture for the health bar and keep it slightly taller than the default Blizzard plate.  Provide options to adjust width and height.
* Display health percentage text aligned to the right of the bar.  Optionally show the numeric value and maximum HP when moused over.
* Colour the bar based on reaction (hostile, neutral, friendly) or class for players.  Tanks can override colours to indicate threat status (e.g., green for secure, yellow for warning, red for danger).

### Cast Bar

* Place a cast bar below the health bar with a subtle border.  Colour the bar to indicate whether the cast is interruptible (yellow/gold for interruptible, grey for immune).
* Show the spell name and remaining cast time.  Animate the bar smoothly and fade it quickly when the cast finishes.
* Provide an option to show uninterruptible casts only to reduce clutter.

### Text & Icons

* Use a clear sans‑serif font consistent with the rest of the UI.  Provide settings for size and weight.
* Show the unit’s name above the health bar.  Use class colours for players and faction colours for NPCs.  Hide level numbers for trivial enemies.
* Display up to four debuff icons to the left or right of the plate.  Increase the size of debuff icons for DoTs in their pandemic window【199123363199383†L175-L179】.
* Add quest markers (exclamation icons) next to quest mobs【199123363199383†L39-L48】.  Make these icons slightly translucent so they do not overpower other elements.
* Show class resources (combo points, holy power, runes) beneath the name or above the plate【199123363199383†L49-L51】.

### Target Indicators

* Implement a small arrow or triangle above the current target’s nameplate【199123363199383†L134-L144】.  Provide options to enable/disable or change the style of the arrow.
* Highlight the target’s health bar with a soft glow.  Customise the glow colour through the configuration.
* Increase the target plate’s size by a small percentage to make it stand out【199123363199383†L166-L171】.  Provide sliders for target width and height in the settings.

### Threat & Aggro

* Use the plate’s border or glow colour to show threat status (e.g., green = tanking securely, yellow = losing threat, red = not tanking).  Tanks can customise the colours for better visibility.
* For DPS and healers, display a small threat percentage number next to the plate when they approach the tank’s threat level.

### Fading & LoS

* Fade plates in and out depending on distance or line‑of‑sight.  The KUI guide recommends using a *line‑of‑sight alpha* slider to reduce clutter when enemies are behind walls or far away【199123363199383†L208-L215】.
* Provide options to disable fading or adjust the transparency threshold.

## Configurable Options

Expose the following settings through a configuration panel or slash commands.  Many of these are inspired by KUI Nameplates’ menus【199123363199383†L83-L99】:

1. **General:** Toggle nameplates on/off, select motion type (stacking vs. overlapping)【199123363199383†L130-L133】 and enable target arrows【199123363199383†L134-L144】.
2. **Health bars:** Choose bar texture and animation style【199123363199383†L146-L150】.  Set bar colours based on class, threat or a unified accent colour.
3. **Cast bars:** Enable/disable cast bars, show or hide uninterruptible casts, change bar colour.
4. **Text:** Enable health text【199123363199383†L185-L194】, configure font type/size, show player guild names on friendly plates【199123363199383†L198-L202】.
5. **Frame sizes:** Adjust width, height and scale of plates and separate target size sliders【199123363199383†L166-L171】.
6. **Auras:** Change icon size for normal and purgeable debuffs【199123363199383†L175-L179】; limit the number of shown debuffs.
7. **Threat:** Configure colour thresholds for secure threat, warning and danger.  Enable/disable threat numbers.
8. **CVars:** Modify line‑of‑sight alpha and other CVar‑controlled behaviours【199123363199383†L208-L215】.

## Advanced Enhancements

1. **Spell cooldowns on nameplates:** Provide optional timers for enemy abilities similar to the *Spell CDs on Nameplates* WeakAura【228995075923660†L108-L110】.  Display an icon with the remaining cooldown next to the plate for dangerous casts (e.g., explosive affixes, mob abilities in Mythic +).  Use this sparingly to avoid clutter.
2. **Target helper & custom colouring:** Offer a plugin interface so players can colour specific mob names or categories.  The KuiNameplates Target Helper plugin allows custom colours for named mobs【199123363199383†L152-L162】; implement a similar system via a table of mob IDs mapped to colours.
3. **Inter‑module communication:** Expose APIs so other modules (e.g., the aura system) can add or remove debuffs and update pandemic indicators.  Ensure that the nameplate module does not maintain its own aura lists but relies on the central aura system.

## Performance Tips

1. **Event‑driven updates:** Avoid running heavy logic in `OnUpdate` scripts.  Update plates when relevant events occur (`NAME_PLATE_UNIT_ADDED`, `NAME_PLATE_UNIT_REMOVED`, `UNIT_AURA`, `UNIT_THREAT_LIST_UPDATE`).
2. **Throttle frequent updates:** When updating cast bars and debuff timers, group updates into periodic ticks (e.g., every 0.05 seconds) to reduce CPU usage.
3. **Reusable frames:** Maintain a pool of nameplate frames and reuse them when enemies spawn/despawn to avoid repeated creation and destruction.

## Summary

By implementing these features and configuration options, you can create nameplates that are both **functional** and **beautiful**.  The design draws inspiration from KUI Nameplates—custom sizes, fonts and colours, target arrows, quest icons and tank‑specific colouring【199123363199383†L39-L51】【199123363199383†L134-L144】—while adding advanced elements like enemy cooldown timers and pandemic‑aware debuff icons.  Maintaining a lightweight implementation ensures high performance even in intense Mythic + fights【199123363199383†L219-L227】.