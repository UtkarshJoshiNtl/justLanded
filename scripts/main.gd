extends Node3D

@onready var player: CharacterBody3D = $Player

var palm_scenes: Array[PackedScene]
var rock_scenes: Array[PackedScene]
var flower_scenes: Array[PackedScene]
var grass_scenes: Array[PackedScene]


func _ready() -> void:
	randomize()
	load_assets()
	build_island()


func load_assets() -> void:
	var p := "res://assets/kenney_nature/Models/GLTF format/"
	palm_scenes = [
		load(p + "tree_palm.glb"),
		load(p + "tree_palmTall.glb"),
		load(p + "tree_palmBend.glb"),
		load(p + "tree_palmShort.glb"),
		load(p + "tree_palmDetailedTall.glb"),
		load(p + "tree_palmDetailedShort.glb"),
	]

	rock_scenes = [
		load(p + "rock_smallA.glb"),
		load(p + "rock_smallB.glb"),
		load(p + "rock_smallC.glb"),
		load(p + "rock_largeA.glb"),
		load(p + "rock_tallA.glb"),
	]

	flower_scenes = [
		load(p + "flower_redA.glb"),
		load(p + "flower_yellowA.glb"),
		load(p + "flower_purpleA.glb"),
	]

	grass_scenes = [
		load(p + "grass.glb"),
		load(p + "grass_large.glb"),
	]


func build_island() -> void:
	build_ground()
	build_grass_ring()
	build_trees()
	build_rocks()
	build_flowers()
	build_water()


func build_ground() -> void:
	var ground := StaticBody3D.new()
	ground.name = "Ground"
	ground.position = Vector3(0, -0.5, 0)
	add_child(ground)

	var vis := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(30, 1, 30)
	var sand_mat := StandardMaterial3D.new()
	sand_mat.albedo_color = Color(0.85, 0.78, 0.58)
	sand_mat.metallic = 0.0
	sand_mat.roughness = 1.0
	box.material = sand_mat
	vis.mesh = box
	ground.add_child(vis)

	var col := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = Vector3(30, 1, 30)
	col.shape = shape
	ground.add_child(col)


func build_grass_ring() -> void:
	var grass := MeshInstance3D.new()
	grass.name = "GrassRing"
	var cyl := CylinderMesh.new()
	cyl.top_radius = 11.0
	cyl.bottom_radius = 11.0
	cyl.height = 0.05
	var grass_mat := StandardMaterial3D.new()
	grass_mat.albedo_color = Color(0.25, 0.65, 0.2)
	grass_mat.metallic = 0.0
	grass_mat.roughness = 1.0
	cyl.material = grass_mat
	grass.mesh = cyl
	grass.position = Vector3(0, 0.01, 0)
	add_child(grass)


func build_trees() -> void:
	var positions := [
		Vector3(-4.5, 0, -3.5), Vector3(5.5, 0, -4.5),
		Vector3(-3.5, 0, 5.5), Vector3(6.5, 0, 3.5),
		Vector3(-7.5, 0, -2.5), Vector3(2.5, 0, -6.5),
		Vector3(-2.5, 0, -5.5), Vector3(4.5, 0, 6.5),
		Vector3(-6.5, 0, 4.5), Vector3(3.5, 0, -3.5),
		Vector3(-5.5, 0, -6.5), Vector3(7.5, 0, 2.5),
		Vector3(-1.5, 0, 7.0), Vector3(-7.0, 0, 1.5),
		Vector3(1.5, 0, -7.0), Vector3(6.0, 0, -1.5),
	]

	for p in positions:
		var scene := palm_scenes[randi() % palm_scenes.size()]
		var tree := scene.instantiate()
		tree.position = p
		var s := 0.8 + randf_range(-0.2, 0.3)
		tree.scale = Vector3(s, s, s)
		tree.rotation_degrees = Vector3(0, randf_range(0, 360), 0)
		add_child(tree)


func build_rocks() -> void:
	var positions := [
		Vector3(2.5, 0, 2.5), Vector3(-3.5, 0, -2.5),
		Vector3(5.5, 0, 1.5), Vector3(-4.5, 0, 3.5),
		Vector3(0.5, 0, -4.5), Vector3(-2.0, 0, -1.0),
		Vector3(3.0, 0, -2.0), Vector3(-1.0, 0, 2.0),
		Vector3(6.5, 0, -3.5), Vector3(-6.0, 0, -1.5),
	]

	for p in positions:
		var scene := rock_scenes[randi() % rock_scenes.size()]
		var rock := scene.instantiate()
		rock.position = p
		var s := 0.6 + randf_range(-0.2, 0.4)
		rock.scale = Vector3(s, s, s)
		rock.rotation_degrees = Vector3(0, randf_range(0, 360), 0)
		add_child(rock)


func build_flowers() -> void:
	var positions := [
		Vector3(1.0, 0, 1.5), Vector3(-1.5, 0, -1.0),
		Vector3(4.0, 0, 0.5), Vector3(-3.0, 0, 4.0),
		Vector3(0.0, 0, -2.5), Vector3(2.5, 0, -4.0),
		Vector3(-4.5, 0, 1.0), Vector3(3.5, 0, -1.0),
		Vector3(-2.0, 0, -4.0), Vector3(5.0, 0, 4.5),
		Vector3(-5.5, 0, -4.0), Vector3(0.0, 0, 5.0),
	]

	for p in positions:
		var scene := flower_scenes[randi() % flower_scenes.size()]
		var flower := scene.instantiate()
		flower.position = p
		var s := 0.5 + randf_range(-0.1, 0.2)
		flower.scale = Vector3(s, s, s)
		flower.rotation_degrees = Vector3(0, randf_range(0, 360), 0)
		add_child(flower)

	var grass_field := grass_scenes[0].instantiate()
	grass_field.scale = Vector3(2, 2, 2)
	grass_field.position = Vector3(1.5, 0, -1.5)
	add_child(grass_field)
	var grass_field2 := grass_scenes[1].instantiate()
	grass_field2.scale = Vector3(2, 2, 2)
	grass_field2.position = Vector3(-2.0, 0, 2.5)
	add_child(grass_field2)


func build_water() -> void:
	var water := MeshInstance3D.new()
	water.name = "Water"
	var plane := PlaneMesh.new()
	plane.size = Vector2(60, 60)
	plane.subdivide_depth = 8
	plane.subdivide_width = 8

	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, blend_mix;

uniform vec4 water_color : source_color = vec4(0.15, 0.55, 0.85, 0.55);

void vertex() {
	vec3 pos = VERTEX;
	float wave = sin(pos.x * 0.8 + TIME * 1.2) * 0.06;
	wave += cos(pos.z * 1.2 + TIME * 0.9) * 0.04;
	VERTEX.y += wave;
}

void fragment() {
	ALBEDO = water_color.rgb;
	ALPHA = water_color.a;
	float shimmer = sin(UV.x * 20.0 + UV.y * 15.0 + TIME * 0.8) * 0.15 + 0.85;
	ALBEDO += vec3(shimmer * 0.1);
}
"""

	var mat := ShaderMaterial.new()
	mat.shader = shader
	plane.material = mat
	water.mesh = plane
	water.position = Vector3(0, -0.8, 0)
	add_child(water)


func _process(delta: float) -> void:
	pass
