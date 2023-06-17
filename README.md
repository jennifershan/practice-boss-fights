# practice-boss-fights
Mod for the Klei multiplayer survival game [Don't Starve Together](https://www.klei.com/games/dont-starve-together) that allows server host to use menu UI to practice boss fights (created mainly for my personal use to avoid manually typing out console commands). Free crafting and map revealing is enabled for all players.

## Mod behavior
| Keybind | Actions |
| --- | --- |
| `P` | Open/close mod menu |
| `CTRL` + `R` | Load last save |
| `CTRL` + `S` | Force save |

## Page view
First page:
![](https://github.com/jennifershan/practice-boss-fights/blob/main/Screenshot%202023-06-10%20at%205.15.08%20AM.png)
Second page:
![](https://github.com/jennifershan/practice-boss-fights/blob/main/Screenshot%202023-06-10%20at%205.14.59%20AM.png)
Third page:
![](https://github.com/jennifershan/practice-boss-fights/blob/main/Screenshot%202023-06-10%20at%205.15.15%20AM.png)

- Cave buttons teleport host to the next closest corresponding entrance or exit.
- Arrow buttons navigate between pages.
- Gather button teleports all players to host location.<br>

Teleportation does not work for players in a different shard (ex. if host gathers all players in overworld, only players in overworld will be teleported). Bosses that are location specific will require host to be in the corresponding shard (ex. trying to fight crab king in caves will not work as intended).

## Installation
Download this repository into `~/Library/Application Support/Steam/steamapps/common/Don't Starve Together/dontstarve_steam.app/Contents/mods`.

## Credited resources
[[Tutorial] Custom User Interfaces](https://forums.kleientertainment.com/forums/topic/118009-tutorial-custom-user-interfaces/)