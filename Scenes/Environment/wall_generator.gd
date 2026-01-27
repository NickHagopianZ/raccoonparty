extends MeshInstance3D

@export var collision_polygon : CollisionPolygon3D
func _ready() -> void:
	if collision_polygon and collision_polygon.polygon:
		var col_shape : ImmediateMesh = ImmediateMesh.new()
		var previous_point : Vector3
		col_shape.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
		
		for point in collision_polygon.polygon:
			var vec3_point = Vector3(point.y, point.x, 0)
			# convert to global basis
			var global_point = collision_polygon.to_global(vec3_point)
			global_point.z *= -1.0
			var local_point = to_local(global_point)
			# local_point += Vector3(-4.0, 0.0, 4.0)
			
			if previous_point:
				col_shape.surface_add_vertex(previous_point - Vector3(0.0, 1.0, 0.0))
				col_shape.surface_add_vertex(previous_point + Vector3(0.0, 1.0, 0.0))
				col_shape.surface_add_vertex(local_point - Vector3(0.0, 1.0, 0.0))
				
				col_shape.surface_add_vertex(local_point - Vector3(0.0, 1.0, 0.0))
				col_shape.surface_add_vertex(previous_point + Vector3(0.0, 1.0, 0.0))
				col_shape.surface_add_vertex(local_point + Vector3(0.0, 1.0, 0.0))

			previous_point = local_point
		
		col_shape.surface_end()
		mesh = col_shape
	position = Vector3(-1.75, 0.0, 1.75)
