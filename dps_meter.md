# DPS Meter Integration

An effective damage meter provides insight into personal and group performance without consuming excessive resources or cluttering the screen.  Instead of embedding a large third‑party addon, this UI includes a **lightweight DPS meter** inspired by Details! Damage Meter.

## Why Not Use an Existing Addon?

Details! is the most widely used combat analysis addon because it parses combat logs into easy‑to‑read charts and meters, tracks damage, healing and threat, and is highly customisable【642746988870965†L309-L318】.  However, it can be heavy, and some players prefer a simpler display that matches a custom UI aesthetic.  Our meter aims to deliver the essentials while remaining lean and integrated.

## Core Features

1. **Real‑time tracking:** Listen to combat log events (`COMBAT_LOG_EVENT_UNFILTERED`) and accumulate damage and healing done by group members.  Distinguish between current and overall segments.
2. **Threat monitor:** Display threat values to help tanks maintain aggro and DPS avoid pulling.  Show threat percentages relative to the current tank.
3. **Multi‑window support:** Allow the player to open multiple meter windows (e.g., current fight, overall data).  Snap windows together; each window should have controls to lock/unlock, resize and group, similar to Details【642746988870965†L396-L403】.
4. **Bookmarks/displays:** Provide quick tabs to switch the displayed metric between damage, healing, absorbs, interrupts, dispels and death logs.  Use right‑click menus on the title bar to change the metric【642746988870965†L409-L431】.
5. **Reporting:** Offer a button to copy the current meter to the clipboard or to print a summary in chat.  This facilitates sharing results after boss fights.
6. **Auto‑reset:** Automatically reset data when entering a Mythic + dungeon, pulling a raid boss or after a certain period of inactivity.
7. **Profiles:** Save meter window positions, sizes and displayed metrics in the overall UI profile.  Players can have different meter setups for raiding and Mythic +.

## Visual Design

1. **Matching the UI:** Use the same fonts, colours and textures defined in the central configuration.  The meter window should be a dark, semi‑transparent rectangle with thin borders.  Rows alternate between subtle background shades for readability.
2. **Bars and text:** Represent each player’s contribution with a horizontal bar and text showing the player name, amount and percentage.  Colour the bar according to class colour or a unified accent colour.  Align values to the right.
3. **Scaling:** Provide a scale slider to adjust the window size.  The number of visible rows should adjust automatically.

## Implementation Notes

### Data Collection

1. Use a table keyed by **player GUID** to accumulate per‑segment data.  On each damage or heal event, add the `amount` to the relevant total.
2. Segment boundaries are defined by entering/exiting combat, starting a new boss encounter, or a manual reset.  Start a new segment when `ENCOUNTER_START` or `PLAYER_REGEN_DISABLED` fires and clear data on `ENCOUNTER_END` or `PLAYER_REGEN_ENABLED`.
3. For threat tracking, periodically call `UnitDetailedThreatSituation("player", target)` for the player and each party member.  Display only the largest threat values to avoid clutter.

### UI Construction

1. Create a frame with a title bar and a scrollable list for rows.  Each row is a StatusBar with associated text fields for the player name and values.
2. Provide drag handles on the corners to resize the frame.  Show small diagonal lines in the corners as in Details【642746988870965†L396-L403】.
3. Right‑clicking the title bar opens a context menu to select the displayed metric (damage, healing, threat, interrupts, etc.)【642746988870965†L409-L431】 and to reset or report data.
4. Use frame snapping to group multiple windows together.  When snapped, windows share a common border and can be moved as one.  Provide a lock icon to ungroup them【642746988870965†L396-L403】.

### Performance Considerations

1. **Throttle updates:** Update the meter display at most once per second to reduce overhead.
2. **Memory usage:** Limit the number of stored segments and keep only summary statistics.  Offer a manual purge command to delete old data.
3. **Profiling:** Use built‑in profiling functions to measure CPU time used by the meter and optimise if necessary.

## Integration with Other Modules

1. **Mythic + panel:** When in a Mythic + dungeon, automatically reset the meter at the start of the run and display a small indicator of current DPS/HPS in the Mythic + panel.  Provide a quick toggle to hide the meter if desired.
2. **Nameplate & aura systems:** Provide APIs for other modules to access the meter data (e.g., show DPS next to player nameplates or highlight the highest performer).
3. **Export:** Expose functions to export data for external analysis (e.g., sending to a logging service or saving to a local file).

## Summary

Building a DPS meter in‑house enables you to tailor its appearance and functionality to your minimal UI.  By drawing inspiration from Details!—a feature‑rich, customisable addon that many players rely on【642746988870965†L309-L318】—and focusing on core metrics, you deliver performance insights without bloat.  The result is a cohesive meter that integrates seamlessly with the rest of your interface and adapts to Mythic + and raiding content.