/// @description Snap to the player

if (instance_exists(Obj_Player)) {
    x = Obj_Player.x;
    y = Obj_Player.y;
    image_xscale = Obj_Player.xScale;
    
	// Check if gravity is normal or flipped
    if (global.grav == 1) {
        image_yscale = 1;
    } else {
        image_yscale = -1;
        y += 1; // Need to draw the sprite a pixel off when flipped
    }
	
	depth = Obj_Player.depth - 1;
} else {
    instance_destroy();
}