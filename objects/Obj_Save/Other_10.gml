/// @description Save the game

if (canSave && instance_exists(Obj_Player) && global.grav == grav) {
	// Make sure the player isn't saving outside the room to prevent save locking
    if (!((Obj_Player.x < 0 || Obj_Player.x > room_width || Obj_Player.y < 0 || Obj_Player.y > room_height) && global.edgeDeath)) {
        canSave = false; // Set it so that the player can't save again immediately
        alarm[0] = 30; // Set alarm so the player can save again
        image_index = 1; //Set the sprite to green
		alarm[1] = 58; // Set alarm to reset image_index
        Save_Game(true); // Save the game
    }
}