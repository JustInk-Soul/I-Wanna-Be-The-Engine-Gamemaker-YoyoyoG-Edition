/// @description Warp the player

if (warpX == 0 && warpY == 0) { // No coordinates set, go to where Obj_PlayerStart is
    with(Obj_Player) {
        instance_destroy();
	}
} else { // Coordinates set, move player to them
    Obj_Player.x = warpX;
    Obj_Player.y = warpY;
}

room_goto(roomTo);