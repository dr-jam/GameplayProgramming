class_name SelectionController
extends Node2D
## Selects squads and issues move or attack orders.
## Units handle movement and combat; this controller only gives orders.

const CLICK_RADIUS := 24.0
const DRAG_THRESHOLD := 9.0
const FORMATION_SPACING := 26.0

@export var selection_bounds: Rect2

var selected_units: Array[Unit] = []
var drag_start := Vector2.ZERO
var drag_end := Vector2.ZERO
var dragging := false
var enabled := true

@onready var drag_fill: Polygon2D = $DragBox/Fill
@onready var drag_outline: Line2D = $DragBox/Outline


## Finish an existing drag before the HUD can consume its release event.
## Only starting a selection needs unhandled input.
func _input(event: InputEvent) -> void:
	if not enabled or not dragging:
		return

	if event is InputEventMouseMotion:
		drag_end = event.position
		_update_drag_box()
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			drag_end = event.position
			_finish_selection(event.shift_pressed)
			get_viewport().set_input_as_handled()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT and is_node_ready():
		_cancel_drag()


## Unhandled input lets HUD buttons consume clicks before they reach the battlefield.
func _unhandled_input(event: InputEvent) -> void:
	if not enabled:
		return

	if event is InputEventMouseButton:
		_handle_mouse_button(event)
	elif event is InputEventKey and event.pressed and not event.echo:
		_handle_key(event)


func _handle_mouse_button(event: InputEventMouseButton) -> void:
	if not selection_bounds.has_point(event.position):
		return

	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_start_selection(event.position)
	elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		_issue_order(event.position)
		get_viewport().set_input_as_handled()


func _handle_key(event: InputEventKey) -> void:
	if event.keycode == KEY_H:
		for unit in selected_units:
			if is_instance_valid(unit):
				unit.hold()
	elif event.keycode == KEY_ESCAPE:
		clear()


func _start_selection(point: Vector2) -> void:
	dragging = true
	drag_start = point
	drag_end = point
	_update_drag_box()


## Small mouse movements still count as clicks. Shift adds troops to the selection.
func _finish_selection(additive: bool) -> void:
	dragging = false
	_update_drag_box()
	if not additive:
		clear()

	var selection_box := Rect2(drag_start, drag_end - drag_start).abs()
	var is_click := selection_box.size.length() <= DRAG_THRESHOLD
	for node in get_tree().get_nodes_in_group("humans"):
		var unit := node as Unit
		if unit == null:
			continue
		if not is_instance_valid(unit) or unit.health <= 0:
			continue

		var selected_by_click: bool = unit.global_position.distance_to(drag_end) <= CLICK_RADIUS
		var selected_by_box: bool = selection_box.has_point(unit.global_position)
		if (is_click and selected_by_click) or (not is_click and selected_by_box):
			_select_unit(unit)


func _select_unit(unit: Unit) -> void:
	if selected_units.has(unit):
		return

	selected_units.append(unit)
	unit.selected = true


## An enemy under the cursor takes priority over a move order.
func _issue_order(point: Vector2) -> void:
	_remove_invalid_units()
	if selected_units.is_empty():
		return

	var enemy := _find_enemy(point)
	if enemy != null:
		for unit in selected_units:
			unit.attack(enemy)
		return

	_move_in_formation(point)


## Use the nearest enemy so focus fire does not depend on scene-tree order.
func _find_enemy(point: Vector2) -> CombatTarget:
	var nearest_enemy: CombatTarget
	var nearest_distance := INF

	for node in get_tree().get_nodes_in_group("combat_targets"):
		var enemy := node as CombatTarget
		if enemy == null or enemy.team == CombatTarget.Faction.HUMANS or enemy.health <= 0.0:
			continue

		var click_radius := CLICK_RADIUS
		if enemy.is_in_group("bases"):
			click_radius += 18.0
		var distance := point.distance_to(enemy.global_position)
		if distance <= click_radius and distance < nearest_distance:
			nearest_enemy = enemy
			nearest_distance = distance

	return nearest_enemy


## Give each troop a slot in a roughly square formation to reduce clumping.
## This spreads out destinations, not the paths taken to reach them.
func _move_in_formation(point: Vector2) -> void:
	var column_count := ceili(sqrt(float(selected_units.size())))
	for index in range(selected_units.size()):
		var column := index % column_count
		@warning_ignore("integer_division")
		var row := index / column_count
		var center_offset := float(column) - float(column_count - 1) / 2.0
		var offset := Vector2(center_offset, row) * FORMATION_SPACING
		selected_units[index].move_to(point + offset)


func clear() -> void:
	_cancel_drag()
	for unit in selected_units:
		if is_instance_valid(unit):
			unit.selected = false
	selected_units.clear()


func _cancel_drag() -> void:
	dragging = false
	_update_drag_box()


## Remove casualties before issuing orders. Walk backward to avoid skipping entries.
func _remove_invalid_units() -> void:
	for index in range(selected_units.size() - 1, -1, -1):
		var unit: Unit = selected_units[index]
		if not is_instance_valid(unit) or unit.health <= 0:
			selected_units.remove_at(index)


## An absolute rectangle lets box-select work in any drag direction.
func _update_drag_box() -> void:
	var visible_drag := dragging and drag_start.distance_to(drag_end) > DRAG_THRESHOLD
	drag_fill.visible = visible_drag
	drag_outline.visible = visible_drag
	if not visible_drag:
		return

	var box := Rect2(drag_start, drag_end - drag_start).abs()
	var top_left := box.position
	var top_right := Vector2(box.end.x, box.position.y)
	var bottom_right := box.end
	var bottom_left := Vector2(box.position.x, box.end.y)
	drag_fill.polygon = PackedVector2Array([
		top_left,
		top_right,
		bottom_right,
		bottom_left,
	])
	drag_outline.points = PackedVector2Array([
		top_left,
		top_right,
		bottom_right,
		bottom_left,
		top_left,
	])
