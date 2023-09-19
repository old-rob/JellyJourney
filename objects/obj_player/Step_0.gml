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
}
y = y + vsp;

// Allow jumping slightly after leaving a platform
if (place_meeting(x,y+1,obj_block)) {
	can_jump = true;
	fall_time = 0;
} else {
	fall_time += 1;
	if (fall_time > 5) {
		can_jump = false;
	}
}

if (_key_up) {
	if (can_jump) {
		can_jump = false;
		vsp -= jump_speed;
	}
} else {
	if (vsp < 0) vsp = max(vsp, -2)
}


// This was for eggshell game
//// Take care of block stepping and breaking
//var _last_stepped_block = stepped_on_block;
//var potential_step_blocks = ds_list_create()
//var _num_potential_step_blocks = instance_place_list(x, y+1, obj_block, potential_step_blocks, true)
//if (!ds_list_find_index(potential_step_blocks, stepped_on_block)) {
//	stepped_on_block = potential_step_blocks[| 0]
//}

//if (_last_stepped_block != noone && _last_stepped_block != stepped_on_block) {
//	if (instance_exists(_last_stepped_block)) {
//		_last_stepped_block.slimed = true;
//	}
//}


// I can't decide if we want to have a ton of blocks in this game 
// or just a few that are stretched out to make the level
// I suppose for level editor it would be simpler to have a block for each space
// Here is one way that could happen, but I don't know if I like it
var _step_blocks = ds_list_create()
var num_touched_blocks = instance_place_list(x, y+1, obj_block, _step_blocks, true)
for (var i = 0; i < ds_list_size(_step_blocks); ++i) {
	if (!_step_blocks[| i].slimed) {
    _step_blocks[| i].slimed = true;
		jelly_quantity -= 0.1
	}
}

image_xscale = jelly_quantity
image_yscale = jelly_quantity

if (jelly_quantity <= 0) {
	// You die	
}