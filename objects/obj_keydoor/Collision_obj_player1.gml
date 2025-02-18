with other
{
	if key_up && other.sprite_index == other.spr_open && grounded
	&& (state == states.normal or state == states.mach1 or state == states.mach2 or state == states.pogo or state == states.mach3 or state == states.Sjumpprep) 
	&& y = other.y + 50 && !instance_exists(obj_fadeout)
	{
		lastroom = room
		scr_soundeffect(sfx_door)
		
		with obj_camera
			chargecamera = 0
		ds_list_add(global.saveroom, id)
		
		sprite_index = spr_lookdoor
		
		targetDoor = other.targetDoor
		targetRoom = other.targetRoom
		image_index = 0	
		state = states.door
		mach2 = 0
		
		other.visited = true
		doorx = other.x + 50;

		instance_create(x, y, obj_fadeout)
	}
}

