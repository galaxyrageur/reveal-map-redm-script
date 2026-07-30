# reveal_map

A RedM script that automatically reveals the entire map (removes the fog of war) as soon as a player connects and spawns in-game.

## Features

- Removes the fog of war from the minimap and the full map
- Triggers automatically when the player spawns
- Fallback safety loop in case the `playerSpawned` event doesn't fire right away
- Lightweight, 100% client-side, no dependencies

## Requirements

- A working RedM server (FXServer)
- Access to your server's `resources` folder

## Installation

1. **Download / copy the files**

   Create a `reveal_map` folder inside your `resources` directory:

   ```
   resources/
   └── [local]/
       └── reveal_map/
           ├── fxmanifest.lua
           └── client.lua
   ```

2. **Add the resource to `server.cfg`**

   Open your `server.cfg` and add the following line (preferably near the end of your resource list):

   ```cfg
   ensure reveal_map
   ```

3. **Restart the server**

   Fully restart your RedM server, or run in the console:

   ```
   refresh
   ensure reveal_map
   ```

4. **Verify**

   Connect to the server with a player account. Open the map (default key: `M`, or whatever your setup uses): it should appear fully revealed, with no grayed-out/undiscovered areas.

## File structure

| File              | Role                                                     |
|-------------------|-----------------------------------------------------------|
| `fxmanifest.lua`  | Resource manifest (declares the client script)            |
| `client.lua`       | Logic that reveals the map when the player spawns          |

## Customization

### Adapting the trigger for a framework (VORP, RedEM:RP, RSG...)

By default, the script uses the native `playerSpawned` event. If you're using a framework that loads the character after this event, replace it with your framework's character-load event instead, for example:

```lua
-- Example with VORP
RegisterNetEvent('vorp:SelectedCharacter')
AddEventHandler('vorp:SelectedCharacter', function()
    RevealFullMap()
end)
```

```lua
-- Example with RedEM:RP
RegisterNetEvent('redem_characters:client:setPed')
AddEventHandler('redem_characters:client:setPed', function()
    RevealFullMap()
end)
```

### Disabling the reveal for specific players

You can gate the call to `RevealFullMap()` behind a rank, an item, or a server-side variable, by triggering it through a custom network event instead of automatically on spawn.

## Troubleshooting

| Issue                                     | Solution                                                                    |
|---------------------------------------------|--------------------------------------------------------------------------|
| The map stays grayed out                    | Make sure the resource starts after any HUD/minimap scripts that might override it |
| The reveal doesn't trigger on spawn         | Adapt the trigger event to your framework (see above)                    |
| Error when starting the resource            | Check the syntax of `fxmanifest.lua` and that RedM is up to date          |

## Notes

- The reveal is applied client-side only: it needs to run again on every connection (already handled automatically by the script).
- The script only affects the fog-of-war display; it doesn't add any extra blips or points of interest.

## License

Free to use and modify for your RedM servers.
