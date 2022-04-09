/// @description Check collision

// Check if the player is touching and shooting
if (place_meeting(x,y,Obj_Player)) {
	if (Input_CheckPressed(global.shootButton)) {
	    event_user(0);
	}
}

// Check if a bullet is touching
if (place_meeting(x,y,Obj_Bullet)) {
	event_user(0);
}