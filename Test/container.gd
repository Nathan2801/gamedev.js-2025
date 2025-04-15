@tool
extends RigidBody2D

@export var _size := Vector2():
	set(value):
		_size = value
		_generate()

@onready var holder := $Holder

class RectOutlineCollision:
	var top: SegmentShape2D
	var left: SegmentShape2D
	var bottom: SegmentShape2D
	var right: SegmentShape2D

func _ready() -> void: 
	pass

@export_tool_button("Generate holder")
var _generate_holderb := func(): _generate_holder()
func _generate_holder() -> void:
	var i := 0.0
	var step := PI/4
	var points := PackedVector2Array()
	var in_multiplier := 10.0
	var out_multiplier := 15.0
	
	while i < PI * 2:
		var point := Vector2(cos(i), sin(i)) * in_multiplier
		points.append(point)
		i += step
	i = PI * 2
	while i > 0.0:
		var point := Vector2(cos(i), sin(i)) * out_multiplier
		points.append(point)
		i -= step
	
	if holder:
		holder.polygon = points
		print("Holder generated")
	else:
		print("Missing a CollisionPolygon2D called 'Holder'")
		
func _make_rect(size: Vector2) -> RectOutlineCollision:
	var out := RectOutlineCollision.new()
	var half := size * 0.5
	
	out.top = SegmentShape2D.new()
	out.top.a = Vector2(-half.x, -half.y)
	out.top.b = Vector2(+half.x, -half.y)
	
	out.left = SegmentShape2D.new()
	out.left.a = Vector2(-half.x, -half.y)
	out.left.b = Vector2(-half.x, +half.y)
		
	out.bottom = SegmentShape2D.new()
	out.bottom.a = Vector2(-half.x, +half.y)
	out.bottom.b = Vector2(+half.x, +half.y)
	
	out.right = SegmentShape2D.new()
	out.right.a = Vector2(+half.x, -half.y)
	out.right.b = Vector2(+half.x, +half.y)
	
	return out

func _generate() -> void:
	var out_segments := _make_rect(_size)
	if $OutTop: $OutTop.shape = out_segments.top
	if $OutLeft: $OutLeft.shape = out_segments.left
	if $OutBottom: $OutBottom.shape = out_segments.bottom
	if $OutRight: $OutRight.shape = out_segments.right
