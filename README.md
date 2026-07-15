# Game Boy project template

A minimal starting point for Game Boy projects written in assembly with [RGBDS](https://rgbds.gbdev.io/).

It is the `base` sample from [Game Boy Programming Adventure](https://nostarch.com/game-boy-coding-adventure), with a Makefile added so the build is a single command. - [RGBDS](https://rgbds.gbdev.io/) — provides `rgbasm`, `rgblink` and `rgbfix`
- An emulator for `make run` (defaults to [BGB](https://bgb.bircd.org/), invoked as `bgb-desktop`)

## Usage

```sh
make          # build the ROM into build/
make run      # build, then launch it in the emulator
make clean    # remove build/
```

The ROM, along with the map and symbol files, ends up in `build/`.

## Layout

| File | Purpose |
| --- | --- |
| `main.rgbasm` | ROM header, entry point, and the main loop |
| `sample.rgbasm` | Your code — `InitSample` runs once, `UpdateSample` runs every frame |
| `utils.rgbinc` | Shared helpers, included by your code |
| `hardware.rgbinc` | Game Boy hardware register definitions |

## Starting a new project

Copy this folder, then edit the two variables at the top of the `Makefile`:

```make
PROJECT := sample   # output name, e.g. build/sample.gb
TITLE   := SAMPLE   # title written into the ROM header (max 11 chars)
```

Every `.rgbasm` file in the folder is assembled and linked automatically, so new source files need no Makefile changes.

The emulator can be swapped without editing the file:

```sh
make run EMULATOR=sameboy
```

## Credits

The sample code, `hardware.rgbinc`, and the project structure come from *Game Boy Programming Adventure* by [mdagois](https://github.com/mdagois), whose samples are at [github.com/mdagois/gca](https://github.com/mdagois/gca). The book is a hard recommendation 
