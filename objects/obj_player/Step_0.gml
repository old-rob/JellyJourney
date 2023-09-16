/// @description


var _key_left = keyboard_check(vk_left) || keyboard_check(ord("A"))
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"))
var _key_up = keyboard_check(vk_up) || keyboard_check(ord("W"))
var _key_down = keyboard_check(vk_down) || keyboard_check(ord("S"))

vsp += global.grav
var _move_dir = _key_right - _key_left;
hsp = _move_dir * walk_speed;



if (place_meeting(x+hsp,y,obj_block)) {
	repeat(8) {
		if (!place_meeting(x+sign(hsp),y,obj_block)) {
			x = x + sign(hsp);
		}
	}
	hsp = 0;
}
x += hsp;

if (place_meeting(x,y+vsp,obj_block)) {
	repeat(8) {
		if (!place_meeting(x,y+sign(vsp),obj_block)) {
			y = y + sign(vsp);
		}
	}
	vsp = 0;
	can_jump = true;
}
y = y + vsp;


// This does not take into account things other than you jumping
// eg a spring that is launching you
if (_key_up) {
	if (can_jump) {
		can_jump = false;
		vsp -= jump_speed;
	}
} else {
	if (vsp < 0) vsp = max(vsp, -jump_speed/3)
}

if (_key_down) {
	if (can_jump) {
		can_jump = false;
		vsp -= 1;
	}
}


// Take care of block stepping and breaking
var _last_stepped_block = stepped_on_block;
var potential_step_blocks = ds_list_create()
var _num_potential_step_blocks = instance_place_list(x, y+1, obj_block, potential_step_blocks, true)
if (!ds_list_find_index(potential_step_blocks, stepped_on_block)) {
	stepped_on_block = potential_step_blocks[| 0]
}

if (_last_stepped_block != noone && _last_stepped_block != stepped_on_block) {
	if (instance_exists(_last_stepped_block)) {
		_last_stepped_block.durability -= 1;
		if (_last_stepped_block.durability <= 0) {
			instance_destroy(_last_stepped_block)	
		}
	}
}
