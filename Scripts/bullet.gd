extends Node3D

const SPEED = 40#Speed at which the bullet moves

#Reference vars:
@onready var mesh = $MeshInstance3D#Get the MeshInstance3D node
@onready var ray = $RayCast3D#Get the RayCast3D node
@onready var particles = $GPUParticles3D#Get the GPUParticles3D node

func _ready():
	pass # Initial setup if needed (currently does nothing).


func _process(delta):#Called every frame. 'delta' is the elapsed time since the previous frame.
	position += transform.basis * Vector3(0, 0, -SPEED) * delta# Move the bullet forward by updating its position based on its speed and direction
	
	if ray.is_colliding():#Check if the raycast is colliding with any object
		print("Bullet is colliding")
		mesh.visible = false#Make the bullet mesh invisible
		particles.emitting = true#Start the particle emission
		ray.enabled = false#Disable the raycast to prevent further collision checks
		var collider = ray.get_collider()# Get the object the ray collided with
		if collider and collider.has_method("destroy_tile"):# Check if the collider is valid (not null) and has the method 'destroy_tile'
			collider.destroy_tile(ray.get_collision_point() - ray.get_collision_normal())#Call the 'destroy_tile' method on the collider with the collision point adjusted by the collision normal
			await get_tree().create_timer(1.0).timeout#Create a timer that waits for 1 second
			queue_free()#Queue the bullet for deletion


func _on_timer_timeout():#This function is called when the timer runs out
	queue_free()#Queue the bullet for deletion
