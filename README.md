
### Prerequisites
- Cargo
- Roblox Studio
- Rojo plugin in roblox studio
- [Rokit](https://github.com/rojo-rbx/rokit)

### Install dependencies with rokit
```bash
rokit install
```

### Install wally packages
```bash
wally install
```

### link wally package types
```bash
wally-package-types -s sourcemap.json Packages/
```

### Build the game
```bash
rojo build -o "game.rbxlx"
```

### Open `gaim.rbxlx` in Roblox Studio then start the Rojo server:

```bash
rojo serve
```

### Connect in roblox studio with the Rojo plugin

#### Recommended vs code plugins:
- Rojo
- Luau language server
- Selene

[the Rojo documentation](https://rojo.space/docs).
