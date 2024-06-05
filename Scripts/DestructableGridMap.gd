extends GridMap

var instance
var destroyed_block = load("res://Scenes/destroyed_block.tscn")


func destroy_tile(collision_point):
	var map_coordinate = local_to_map(collision_point)
	set_cell_item(map_coordinate, -1)
	
	#Handle block destruction particle effect.
	instance = destroyed_block.instantiate()
	instance.position = map_to_local(map_coordinate)
	instance.emitting = true
	print("Block destroyed")
	add_child(instance)
	
func _process(delta):
	pass
