# Apia–Carnova system Addon

A small addon mod for [Apia](https://mods.factorio.com/mod/apia) (Factorio 2.1 / Space Age). It adds optional module slots and per-effect module toggles to the Artificial Hive, plus a couple of quality-of-life toggles for Apia's tiles.

All features are off or neutral by default and configured through **startup settings** (changing them requires a game restart).

## Features

### Artificial Hive: module slots
Sets the number of module slots on the Artificial Hive (0–8, default 6). A value of 0 keeps the vanilla behavior (no modules).

### Artificial Hive: per-effect toggles
Individually allow the **speed**, **productivity**, **consumption**, **pollution** and **quality** effects on the Artificial Hive. These settings control `allowed_effects`, so they apply both to modules inserted in the machine itself and to module effects received from beacons.

Enabling productivity also enables `allow_productivity` on the hive's honeycomb recipes (the only recipes in the `artificial-hive-process` category), since those don't allow productivity by default.

### Biosynthesizer: craft Apia tiles
Adds Apia's tile recipes — **wax platform** and the **artificial honey/copper/iron soil** — to the Biosynthesizer (it can already craft apicultural recipes). The artificial soil recipes keep their restriction to the Apia surface.

### Foundation: placeable on Fat Jelly
Allows the vanilla **foundation** item to be placed on Fat Jelly (`carnova-biome1`), and makes shift-placed buildings automatically fill Fat Jelly with foundation, the same way the game auto-fills lava oceans.

## Settings

All settings are startup settings (require a restart):

| Setting | Default | Description |
| --- | --- | --- |
| Artificial hive: module slots | 6 | 0–8 module slots on the Artificial Hive |
| Artificial hive: allow *effect* | off | speed / productivity / consumption / pollution / quality |
| Biosynthesizer: craft Apia tiles | off | wax platform + artificial soil recipes in the Biosynthesizer |
| Foundation: placeable on Fat Jelly | off | foundation on Fat Jelly, incl. shift-place auto-fill |

## Compatibility

- Requires **Apia >= 0.5.0**.
- Additive only — the addon never deletes or replaces prototypes, so it should be safe with other Apia-related mods.

## License

MIT — see [LICENSE](LICENSE).
