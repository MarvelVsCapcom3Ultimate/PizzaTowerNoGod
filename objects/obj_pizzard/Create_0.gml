event_inherited();

grav = 0.5;
hsp = 0;
vsp = 0;

state = states.walk
stunned = 0
alarm[0] = 150
roaming = true
collectdrop = 5
flying = false
straightthrow = false
cigar = false
cigarcreate = false
stomped = false
shot = false
thrown = false
reset = false
bombreset = 0
hp = 2
grounded = true

idlespr = spr_pizzard_walk
stunfallspr = spr_pizzard_stun
walkspr = spr_pizzard_walk
stunspr = spr_pizzard_stun
grabbedspr = spr_pizzard_stun
scaredspr = spr_pizzard_scared
throwspr = spr_pizzard_shoot
//image_xscale = -1
flash = false
slapped = false
birdcreated = false
boundbox = false
spr_dead = spr_pizzard_dead
important = false
heavy = true
depth = 0

grabbedby = 0

paletteselect = string_startswith(room_get_name(room), "chateau");
spr_palette = palette_pizzard
stuntouchbuffer = 0

if global.snickrematch
{
	idlespr = spr_pizzard_walk_re
	stunfallspr = spr_pizzard_stun_re
	walkspr = spr_pizzard_walk_re
	grabbedspr = spr_pizzard_stun_re
	scaredspr = spr_pizzard_stun_re
	spr_dead = spr_pizzard_dead_re
	throwspr = spr_pizzard_shoot_re
}
sprite_index = walkspr;
