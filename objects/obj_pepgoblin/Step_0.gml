if room == rm_editor exit;

switch state
{
	case states.idle: scr_enemy_idle (); break;
	case states.charge: scr_enemy_charge (); break;
	case states.turn: scr_enemy_turn (); break;
	case states.walk: scr_enemy_walk (); break;
	case states.land: scr_enemy_land (); break;
	case states.hit: scr_enemy_hit (); break;
	case states.stun: scr_enemy_stun (); break;
	case states.pizzagoblinthrow: scr_pizzagoblin_throw (); break;
	// grabbed state here
}


if state == states.stun && stunned > 100 && !birdcreated
{
	birdcreated = true
	with instance_create(x, y, obj_enemybird)
		ID = other.id
}

if state != states.stun
	birdcreated = false


//Flash
if flash == true && alarm[2] <= 0
   alarm[2] = 0.15 * room_speed; // Flashes for 0.8 seconds before turning back to normal

if state != states.grabbed
	depth = 0

if state != states.stun
	thrown = false

//Scared
scr_scareenemy()

if bombreset > 0
	bombreset = max(bombreset - 1, 0);

//Identify the player
var targetplayer = instance_nearest(x, y, obj_player)

//Kick
if instance_exists(targetplayer)
{
	if x != targetplayer.x && state != states.pizzagoblinthrow && targetplayer.state != states.tumble && bombreset == 0 && grounded
	{
		if targetplayer.x > x - 80 && targetplayer.x < x + 80 && y <= targetplayer.y + 100 && y >= targetplayer.y - 100
		{
			if state == states.walk && !rematchscare
			{
				image_index = 0
				sprite_index = spr_pepgoblin_kick
				if global.snickrematch
					sprite_index = spr_pepgoblin_kick_re
				image_xscale = -sign(x - obj_player.x)
				state = states.pizzagoblinthrow
			}
		}
	}
}
if grounded && state == states.pizzagoblinthrow && floor(image_index) == 3
	vsp = -5

if !boundbox
{
	with instance_create(x, y, obj_baddiecollisionbox)
	{
		sprite_index = spr_pepgoblin
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}