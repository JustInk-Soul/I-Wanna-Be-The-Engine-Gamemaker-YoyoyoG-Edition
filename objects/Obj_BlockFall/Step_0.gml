/// @description Check if near player and move

if (vspeed == 0 && instance_exists(Obj_Player)) {
    if (place_meeting(x,y-Obj_Player.vspeed-(global.grav),Obj_Player)) {
        vspeed = 2; // Touching the player, start falling
	}
}

event_inherited(); // Movement checks