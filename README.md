# SurvivorIO

![SurvivorIO](https://github.com/alpapaydin/Godot4-Multiplayer-Survivor-IO-Game/blob/master/preview.png?raw=true)

Welcome to **SurvivorIO** – a multiplayer web game designed to demonstrate multiplayer features within the Godot 4.x. This project specifically targets implementation of an authoritative multiplayer MMO structure utilizing WebSocket with SSL to support HTML5 exports, similar to .io games commonly played in browsers. Experience a rich blend of survival, crafting, and PvP combat in a dynamic and immersive environment.

## Features

- **Authoritative Multiplayer Server**: Ensures consistent and fair gameplay with reliable synchronization across all players. Utilized Godot's MultiplayerSynchronizer and MultiplayerSpawner nodes in action, blended with custom RPCs.
- **Noise Map Generation**: Creates procedurally generated landscapes that offer diverse and visually appealing environments.
- **Character Customization**: Personalize your character with unique features to distinguish yourself in the game world.
- **PvP Combat**: Engage in intense player-versus-player battles, testing your skills against others.
- **Inventory System**: Efficiently manage your items and resources with a user-friendly interface.
- **Crafting**: Develop weapons, tools, and various items essential for your survival and progression.
- **Player Scoring**: Players gain score and stats by killing enemies and destroying resources.
- **Day-Night Cycle**: Experience the realistic passage of time with dynamically changing lighting conditions.
- **Mob Spawning and Combat**: Encounter and combat various hostile creatures, each presenting unique challenges.
- **Ranged and Melee Combat**: Utilize a variety of weapon types to defeat enemies from a distance or up close.
- **Dedicated Server**: Enjoy stable and responsive gameplay on a robust server infrastructure.
- **Chat System**: Communicate in real-time with other players, enhancing the multiplayer experience.
- **Minimap**: Easily navigate the game world with an intuitive minimap feature.
- **Durability**: Manage your equipment's durability, ensuring you plan and execute your actions strategically.
- **Export Templates**: Export templates for Web Client and Linux Server are included.

## Getting Started

### Prerequisites

- [Godot Engine 4.x](https://godotengine.org/)

### Installation

1. Clone the repository:
	```sh
	git clone https://github.com/yourusername/SurvivorIO.git
	```
2. Navigate to the project directory:
	```sh
	cd SurvivorIO
	```

### Running the Game

1. Set the server IP:
	- Open `Constants.gd` autoload and set `DEFAULT_SERVER_IP` to `"localhost"` for local testing.
	```gdscript
	var DEFAULT_SERVER_IP = "localhost"
	```
2. Start the server from the Godot editor. Server is designed to be a headless instance so it is not playable.
3. Launch the web client or another instance from the Godot editor to automatically connect to server.

### Deployment

1. If you want to upload to your server or itch.io, you need to use `wss`:
	- Generate Let's Encrypt certificates.
	- Place them in the `assets/certs` folder.
	- Set host info and cert paths in `Constants.gd`, and `USE_SSL` to `true`.
	- The clients will automatically connect to the server using these certificates.

2. You can use predefined export templates for linux server and web client.

## Development Status

### Completed

- 2D Noise map generation
- Character customization
- Authoritative multiplayer server
- Synchronization & Replication
- Web client
- Character animation
- PvP combat
- Object spawner replication
- Reconnecting player replication
- Item and drop system
- Object types
- Inventory UI
- Harvesting (axe, pickaxe)
- Weapons
- Crafting
- Object spawner timer
- Day-night cycle & UI by bitbrain
- Torch and lighting
- Mob spawner
- Mobs
- Player ranged attack
- Mob ranged attack
- Projectile types
- Item durability
- Minimap
- Dedicated server
- Server Deployment
- Chat
- Movement localization
- Content

### To Do

- Fix small error with player despawn:
  ```sh
  get_node: Node not found: "/root/Game/Level/Main/Players/(playerId)" (absolute path attempted from "/root")
