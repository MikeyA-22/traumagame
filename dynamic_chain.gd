@tool

class_name DynamicChain extends Node3D



@export_group("Chain Setup")
@export_range(2, 50) var link_count: int = 10:
	set(value):
		link_count = value
		if Engine.is_editor_hint():
			_regenerate_chain()
@export var link_length: float = 0.3:
	set(value):
		link_length = value
		if Engine.is_editor_hint():
			_regenerate_chain()
@export var link_radius: float = 0.05:
	set(value):
		link_radius = value
		if Engine.is_editor_hint():
			_regenerate_chain()

@export_group("Joint Settings")
@export var angular_limit_degrees: float = 30.0
@export var twist_limit_degrees: float = 15.0


@export_group("Physics Properties")
@export var link_mass: float = 0.5
@export var gravity_scale: float = 1.0
@export var link_damping: float = 0.5

@export_group("Collision")
@export_flags_3d_physics var link_collision_layer: int = 1
@export_flags_3d_physics var link_collision_mask: int = 1

@export_group("Mesh Settings")

@export var link_mesh: Mesh = null:
	set(value):
		link_mesh = value
		if Engine.is_editor_hint():
			_regenerate_chain()

@export var mesh_scale: float = 1.0:
	set(value):
		mesh_scale = value
		if Engine.is_editor_hint():
			_regenerate_chain()

@export_enum("Chain", "Rope") var chain_type: String = "Chain":
	set(value):
		chain_type = value
		if Engine.is_editor_hint():
			_regenerate_chain()

@export_group("Attachment")
@export var attached_scene: PackedScene = null
@export var attached_node: Node3D = null

@export_group("References")
@export var anchor: StaticBody3D
@export var link_container: Node3D





var links: Array[RigidBody3D] = []
var joints: Array[Generic6DOFJoint3D] = []

func _ready() -> void:
	
	if not Engine.is_editor_hint():
		_generate_chain()


func _generate_chain() -> void:
	clear_chain()
	#Generate links
	for i in range(link_count):
		var link = create_link(i)
		link_container.add_child(link)
		links.append(link)
		link.position = Vector3(0, - (i + 1) * link_length,0)
		
	# Wait for links ot be in tree
	await get_tree().process_frame
		
		
		
		#Create joints between links
	for i in range(link_count):
		var body_a = anchor if i == 0 else links[i - 1]
		var body_b = links[i]
		
		var joint = _create_joint(body_a,body_b)
		body_b.add_child(joint)
		joints.append(joint)
	# Attach scene to bottom link if provided
	if attached_scene and links.size() > 0:		
		var attachment = attached_scene.instantiate()
		link_container.add_child(attachment) # Add as sibling to avoid cleanup
		
		var bottom_link = links[links.size() - 1]
		attachment.global_position = bottom_link.global_position + Vector3(0, -link_length, 0)

		# If attachment is RigidBody3D, connect it with a joint
		var joint = _create_joint(bottom_link, attachment)
		attachment.add_child(joint)
	if attached_node and links.size() > 0:
		var bottom_link = links[links.size()-1]
		var joint = _create_joint(bottom_link, attached_node)
		bottom_link.add_child(joint)
		print("parent node: ",attached_node.get_parent())
		print("joint parent: ", joint.get_parent())
	


func create_link(index: int)->RigidBody3D:
	var link = RigidBody3D.new()
	link.name = "Link_" + str(index)
	
	 
	#Physics properties
	link.mass = link_mass
	link.gravity_scale = gravity_scale
	link.linear_damp = link_damping
	link.angular_damp = link_damping
	link.collision_layer = link_collision_layer
	link.collision_mask = link_collision_mask
	
# Mesh – custom or procedural
	var mesh_instance = MeshInstance3D.new()

	if chain_type == "Chain" and link_mesh != null:
		# Use custom mesh
		mesh_instance.mesh = link_mesh
	else:
			# Procedural cylinder
		var cylinder = CylinderMesh.new()
		cylinder.height = link_length
		cylinder.top_radius = link_radius * (0.7 if chain_type == "Rope" else 1.0)
		cylinder.bottom_radius = cylinder.top_radius
		mesh_instance.mesh = cylinder

	mesh_instance.scale = Vector3.ONE * mesh_scale
	link.add_child(mesh_instance)

	
	#Collision shape
	var collision_shape = CollisionShape3D.new()
	var shape = CylinderShape3D.new()
	shape.height = link_length
	shape.radius = link_radius
	collision_shape.shape = shape
	link.add_child(collision_shape)
	
	
	return link
	
func _create_joint(body_a: Node3D, body_b) -> Generic6DOFJoint3D:
	var joint = Generic6DOFJoint3D.new()
	joint.name = "Joint_to_" + body_a.name
	joint.position = Vector3(0, link_length * 0.5, 0)
	
	# Lock X axis(no left/right stretch)
	joint.set_flag_x(Generic6DOFJoint3D.FLAG_ENABLE_LINEAR_LIMIT,true)
	joint.set_param_x(Generic6DOFJoint3D.PARAM_LINEAR_LOWER_LIMIT,0)
	joint.set_param_x(Generic6DOFJoint3D.PARAM_LINEAR_UPPER_LIMIT,0)
	
	# Lock Y axis(no up/down stretch)
	joint.set_flag_y(Generic6DOFJoint3D.FLAG_ENABLE_LINEAR_LIMIT,true)
	joint.set_param_y(Generic6DOFJoint3D.PARAM_LINEAR_LOWER_LIMIT,0)
	joint.set_param_y(Generic6DOFJoint3D.PARAM_LINEAR_UPPER_LIMIT,0)
	
	# Lock Z axis(no forward/back stretch)
	joint.set_flag_z(Generic6DOFJoint3D.FLAG_ENABLE_LINEAR_LIMIT,true)
	joint.set_param_z(Generic6DOFJoint3D.PARAM_LINEAR_LOWER_LIMIT,0)
	joint.set_param_z(Generic6DOFJoint3D.PARAM_LINEAR_UPPER_LIMIT,0)
	
	#Angular limits (swing range)
	var angular_limit_rad =  deg_to_rad(angular_limit_degrees)
	var twist_limit_rad = deg_to_rad(twist_limit_degrees)
	
	
	
	#X axis swing (pitch)
	joint.set_flag_x(Generic6DOFJoint3D.FLAG_ENABLE_ANGULAR_LIMIT,true)
	joint.set_param_x(Generic6DOFJoint3D.PARAM_ANGULAR_LOWER_LIMIT, -angular_limit_rad)
	joint.set_param_x(Generic6DOFJoint3D.PARAM_ANGULAR_UPPER_LIMIT, angular_limit_rad)
	
	#Y axis twist
	joint.set_flag_y(Generic6DOFJoint3D.FLAG_ENABLE_ANGULAR_LIMIT,true)
	joint.set_param_y(Generic6DOFJoint3D.PARAM_ANGULAR_LOWER_LIMIT, -twist_limit_rad)
	joint.set_param_y(Generic6DOFJoint3D.PARAM_ANGULAR_UPPER_LIMIT, twist_limit_rad)
	
	#Z axis swing (roll)
	joint.set_flag_z(Generic6DOFJoint3D.FLAG_ENABLE_ANGULAR_LIMIT,true)
	joint.set_param_z(Generic6DOFJoint3D.PARAM_ANGULAR_LOWER_LIMIT, -angular_limit_rad)
	joint.set_param_z(Generic6DOFJoint3D.PARAM_ANGULAR_UPPER_LIMIT, angular_limit_rad)
	
	
	#Set node paths after joint is in tree
	joint.ready.connect(func():
		joint.node_a = joint.get_path_to(body_a)
		joint.node_b = NodePath("..")
		)
	
	
	return joint


func clear_chain() -> void:
	#Clear existing
	
	for link in links:
		if is_instance_valid(link):
			link.queue_free()
	links.clear()
	joints.clear()
	
	for child in link_container.get_children():
		child.queue_free()
	

func _regenerate_chain():
	if Engine.is_editor_hint():
		clear_chain()
		# Wait for cleanup
		await get_tree().process_frame
		
		# Generate new chain
		_generate_chain()
