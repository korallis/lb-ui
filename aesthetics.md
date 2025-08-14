# Aesthetics & Styling Guidelines

Creating a clean and polished UI involves more than functional modules; the look and feel of every element must be consistent.  This document provides guidelines for selecting colours, fonts, textures and animations that complement each other and reinforce the minimalist theme.

## Colour Palette

1. **Neutral base colours:** Use dark greys or semi‑transparent blacks for backgrounds (e.g., `rgba(0,0,0,0.5)` for panels).  This allows icons and text to stand out without distraction.
2. **Accent colours:** Choose one or two accent colours to highlight important elements such as health bars, progress bars and selected targets.  Many players prefer class colours for health bars; KUI Nameplates also support custom target colours via a plugin【199123363199383†L152-L162】.  Provide an option in the configuration to switch between class colours and a unified accent colour.
3. **Threat & status colours:** Use green/yellow/red glows or bar tints to indicate secure threat, insecure threat and loss of aggro.  Debuffs entering the pandemic window should gain a red border【250441765295417†L147-L151】.
4. **Text colours:** White or light grey text is easiest to read against dark backgrounds.  Use subtle colour coding (e.g., green for healing numbers, red for damage) sparingly.

## Typography

1. **Font choice:** Select a clear, sans‑serif font that scales well at small sizes.  Avoid decorative fonts that can be hard to read.  Provide a global setting so all modules use the same font and weight.
2. **Sizes and weights:** Use larger font sizes for critical information (e.g., player health and resource values) and smaller sizes for secondary details.  Bold text can emphasise player names or active timers.  The ability to adjust health text size on nameplates is recommended【199123363199383†L185-L194】.
3. **Shadows:** Soft text shadows can improve readability on complex backgrounds.  Use a very small blur and low opacity.

## Textures & Animations

1. **Flat textures:** Prefer flat or lightly textured backgrounds over high‑gloss surfaces.  The Arcane Intellect guide suggests using simple bar textures like “OmniCD Flat” for health bars and enabling smooth animations【199123363199383†L146-L150】; this aesthetic keeps the interface modern and clean.
2. **Borders:** Use thin borders with slightly lighter or darker shades than the panel background.  Avoid thick bevels or glowing effects except where attention is necessary (e.g., active cast bars or pandemic DoT bars).
3. **Animations:** Keep animations subtle: fade bars in/out, slide cooldowns into view, smooth resizing transitions.  Avoid flashy pulses except for urgent events like impending interrupts or expiring defensive cooldowns.

## Layout & Spacing

1. **Grid system:** Align frames using a consistent grid.  Maintain equal margins between panels and avoid overlapping elements.  This improves readability and gives the UI a professional look.
2. **Scaling:** Provide a master UI scale setting.  Each module should scale proportionally with this value.  Additional scale sliders can be exposed for specific modules such as nameplates or action bars.
3. **Padding:** Add internal padding to panels so that text and icons do not touch the borders.  Nameplates benefit from slightly enlarged target frame sizes【199123363199383†L166-L171】 and larger debuff icons【199123363199383†L175-L179】 to improve clarity.

## Visual Enhancements

1. **Target indicators:** Use discrete arrows above the current target’s nameplate【199123363199383†L134-L144】 and a coloured glow around the health bar to quickly differentiate it from others.  Ensure the arrow and glow colours match the accent palette.
2. **Quest markers:** Display small exclamation icons on nameplates of quest mobs【199123363199383†L39-L48】; maintain consistent sizing and spacing with other icons.
3. **Line‑of‑sight fading:** Apply lower opacity to nameplates behind obstacles; KUI Nameplates implements this through a line‑of‑sight alpha slider【199123363199383†L208-L215】.  Use a similar mechanism for other frames (e.g., fade party frames when out of range).

## Accessibility & Customisation

1. **Configurable:** Expose colour and font settings via a configuration panel.  Provide presets for different colour schemes (dark/light, class‑coloured, high‑contrast).  The Cooldown Manager roadmap indicates that players value the ability to select which spells appear and reorder them【805652344164862†L29-L43】; apply this philosophy to visuals as well.
2. **Accessibility features:** Offer larger fonts and simplified colour modes for colour‑blind players.  Provide toggles to increase the size of important indicators such as debuffs and nameplate glows.
3. **Profiles:** Allow saving and loading of profiles so players can switch between Mythic + and levelling layouts.  Blizzard plans to add profiles to the Cooldown Manager【250441765295417†L161-L178】; align your design with this concept.

## Summary

By following these aesthetic guidelines—neutral bases, accent colours, clean fonts, flat textures and subtle animations—you will achieve a minimalist yet polished look.  Keep customisation options flexible so players can tailor the UI to their preferences, just as KUI Nameplates provides numerous settings for bar textures, target arrows, and fading【199123363199383†L130-L150】【199123363199383†L134-L144】.  Consistency and restraint are key: let the gameplay shine while your interface quietly communicates everything the player needs to know.