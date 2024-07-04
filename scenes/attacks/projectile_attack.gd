extends Node2D

signal hitPlayer(body)

var spawner
var projectileData := {}
var projectileId := "":
	set(value):
		projectileId = value
		projectileData = Items.projectiles[value]
		for stat in projectileData.keys():
			set(stat, projectileData[stat])
			%Sprite2D.texture = load("res://assets/characters/attacks/"+value+".png")
		
# maxHits, speed, time, curveSpeed
var targetGroup := "damageable"
var maxHits := 1
@export var speed: float = 10.0
@export var time: float = 1.0
var curveSpeed := true
var elapsed_time: float = 0.0
var hitBodies := []
var targetPos : Vector2:
	set(value):
		targetPos = value
		direction = (targetPos - position).normalized()
var direction: Vector2

func _process(delta: float):
	if multiplayer.is_server():
		if curveSpeed:
			position += direction * speed * elapsed_time
		else:
			position += direction * speed
		elapsed_time += delta
		if elapsed_time >= time:
			disappear()

func _on_animated_sprite_2d_animation_finished():
	if multiplayer.is_server():
		queue_free()

func _on_attack_area_body_entered(body):
	if !multiplayer.is_server():
		return
	if body.is_in_group(targetGroup) and body not in hitBodies:
		if spawner and body == spawner:
			return
		hitBodies.append(body)
		hitPlayer.emit(body)
		maxHits -= 1
	if maxHits <= 0:
		disappear()
		
func disappear():
	if !multiplayer.is_server():
		return
	queue_free()
