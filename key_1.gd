extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 



func _on_area_key_body_entered(_body):
	Global.keys_founded.append("door_" + self.name.split("_")[1])
	queue_free()
