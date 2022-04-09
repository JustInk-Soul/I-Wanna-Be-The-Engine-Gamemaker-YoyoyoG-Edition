/// @description Flip player rightside-up

if (place_meeting(x,y,Obj_Player)) {
	if (global.grav == -1) {
	    Player_FlipGrav();
	}
}