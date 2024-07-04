extends Node

#Multiplayer
const SERVER_IP := "localhost"
const PORT := 3131
const USE_SSL := false # put certs in assets/certs, a free let's encrypt one works for itch.io
const TRUSTED_CHAIN_PATH := ""
const PRIVATE_KEY_PATH := ""

#Map
const MAP_SIZE := Vector2i(64,64) # see map.gd for tileset specific constants
const MAX_OBJECTS := 30
const MAX_ENEMIES_PER_PLAYER := 2 # see main.gd for more object and enemy spawner constants

#Player
const MAX_INVENTORY_SLOTS := 9
const OBJECT_SCORE_GAIN := 1
const MOB_SCORE_GAIN := 2
const PK_SCORE_GAIN := 4
# more player related consts are in player.gd
# Item, object and equipment data is in "Items" autoload.
