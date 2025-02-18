if state == 1
{
	if obj_player1.state != states.normal
		state = 0;
	else
	{
		scr_getinput(true);
		
		var move = -key_up2 + key_down2;
		if move != 0
		{
			var selprev = sel;
			sel = clamp(sel + move, 0, array_length(hub_array) - 1);
		
			if sel != selprev
				scr_soundeffect(sfx_step);
		}
		
		if key_jump
		{
			if (hub_array[sel][1] == PP_room1)
			&& (global.timeattack or global.modifier != -1)
				scr_soundeffect(sfx_denied);
			else
				state = 2;
		}
		else if key_slap2
		{
			scr_soundeffect(sfx_enemyprojectile);
			state = 0;
		}
	}
}

if state == 2
{
	obj_player1.targetRoom = hub_array[sel][1];
	if obj_player1.targetRoom != room
	{
		state = 3;
		scr_soundeffect(sfx_door)
	
		obj_camera.chargecamera = 0
		with obj_player1
		{
			lastroom = room;
			sprite_index = spr_lookdoor;
		
			targetDoor = other.targetDoor;
			image_index = 0;
			state = states.door;
			mach2 = 0;
		}
		instance_create(x, y, obj_fadeout)
	}
	else
	{
		state = 0;
		obj_player1.state = states.normal;
	}
}