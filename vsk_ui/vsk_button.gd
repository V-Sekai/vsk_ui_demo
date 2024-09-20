@tool
class_name VSKButton
extends BaseButton

@export_multiline var text: String = "" :
	set(value):
		text = value
		if _label:
			_label.text = text
			update_minimum_size()

@export_category("Internal Nodes")
@export var _background: Panel = null
@export var _button_drop_shadow: Panel = null
@export var _thumbnail_background: Panel = null
@export var _thumbnail_icon: TextureRect = null
@export var _label: Label = null

func _get_border_size() -> Vector2:
	return Vector2(8, 8)

func _get_minimum_size() -> Vector2:
	var minimum_size: Vector2 = Vector2(_get_border_size().x * 2, 0)
	#if _label:
	#	minimum_size += _label.get_size()

	return minimum_size

func _update_theme() -> void:
	var shadow_offset_x: float = get_theme_constant("shadow_offset_x", "VSKButton")
	var shadow_offset_y: float = get_theme_constant("shadow_offset_y", "VSKButton")
	
	var background_stylebox: StyleBox = get_theme_stylebox("background", "VSKButton")
	_background.set("theme_override_styles/panel", background_stylebox)
	
	var thumbnail_background_stylebox: StyleBox = get_theme_stylebox("thumbnail_background", "VSKButton")
	_thumbnail_background.set("theme_override_styles/panel", thumbnail_background_stylebox)

	_button_drop_shadow.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_button_drop_shadow.set_position(Vector2(shadow_offset_x, shadow_offset_y))

func _process(_delta: float) -> void:
	if _thumbnail_icon:
		_thumbnail_icon.pivot_offset = _thumbnail_icon.size / 2

func _notification(p_what: int) -> void:
	match p_what:
		NOTIFICATION_THEME_CHANGED:
			_update_theme()
			
func _ready() -> void:
	#ignore_texture_size = true
	_update_theme()
