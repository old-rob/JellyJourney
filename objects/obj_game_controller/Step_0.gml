/// @description

var click = mouse_check_button_pressed(mb_left)

if (click) {
	var block = instance_create_layer(mouse_x, mouse_y, layer, obj_block)
	with block {
		move_snap(32, 32)
	}
}
