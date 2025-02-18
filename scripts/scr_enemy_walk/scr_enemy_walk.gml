function scr_enemy_walk()
{
	switch object_index
	{
		// non-moving enemies
		case obj_trash:
		case obj_fencer:
		case obj_rancher:
		case obj_banditochicken:
		case obj_ancho:
		case obj_thug_red:
		case obj_thug_green:
		case obj_thug_blue:
			hsp = 0;
			break;
		
		case obj_ninja:
			if global.gameplay != 0
			{
				hsp = 0;
				break;
			}
		
		// default movement
		default:
			if movespeed != 0
				hsp = image_xscale * (movespeed + (global.baddiespeed - 1));
			break;
		
		// special cases
		case obj_tankOLD:
			if slide_buffer <= 0
				hsp = image_xscale * movespeed;
			break;
		
		case obj_pickle:
			if !walked
			{
				hsp += accel * sign(image_xscale)
				if hsp < -movespeed or hsp > movespeed
				{
					hsp = movespeed * sign(image_xscale)
					walked = true;
				}
			}
			else
			{
				hsp -= deccel * sign(image_xscale)
				if hsp > -deccel_threshold && hsp < deccel_threshold
					walked = false;
			}
			break;
	}
	
	var railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then hsp += railmeet.spdh;
	
	if !grounded &&	object_index != obj_noisey && object_index != obj_ancho && object_index != obj_miniufo// && object_index != obj_clownmato
	&& global.gameplay != 0
	{
		if object_index != obj_babybear
			state = states.stun;
		hsp = 0;
	}
	
	//Animation
	image_speed = 0.35;
	
	// turn around on wall
	var sold = scr_solid(x + image_xscale, y, true, true);
	if place_meeting(x + hsp * 2, y, obj_hallway)
	or (sold && !inst_relation(sold, obj_slope))
	{
		hsp = 0;
		if object_index == obj_forknight or object_index == obj_smurfknight
		{
			image_xscale *= -1
			image_index = 0
			sprite_index = turnspr
			state = states.idle
		}
		else if object_index == obj_indiancheese && scr_stylecheck(2)
		{
			image_xscale *= -1
			image_index = 0
			sprite_index = spr_indiancheese_turn
			state = states.idle
		}
		else if object_index == obj_tankOLD or object_index == obj_tank
		{
			image_xscale *= -1
			image_index = 0
			sprite_index = spr_tank_turn 
			state = states.turn
		}
		else
		{
			image_xscale *= -1
			if object_index == obj_pickle
				hsp = 0;
			if object_index == obj_miniufo
				turntimer = 600;
		}
	}
	
	// on platform and about to fall, turn around
	if object_index != obj_ancho && object_index != obj_miniufo
	{
		if (!scr_solid(x + hsp * 5, y + 30) && !scr_solid(x + hsp * 5, y + 1)
		&& !place_meeting(x + hsp, y + 30, obj_slope))
		or place_meeting(x + hsp * 5, y + 30, obj_water)
		{
			if movespeed > 0 && grounded
			{
				if object_index == obj_ninja && global.gameplay == 0
				{
					vsp = -11
			
					image_index = 0
					image_xscale = -sign(x - obj_player.x)
					state = states.charge
				}
				else if object_index == obj_forknight or object_index == obj_smurfknight
				{
					image_xscale *= -1
					image_index = 0
					sprite_index = turnspr
					state = states.idle
				}
				else if object_index == obj_tankOLD or object_index == obj_tank
				{
					image_xscale *= -1
					image_index = 0
					sprite_index = spr_tank_turn 
					state = states.turn
				}
				else
				{
					image_xscale *= -1
					if object_index == obj_pickle
						hsp = 0;
				}
			}
		}
	}
}