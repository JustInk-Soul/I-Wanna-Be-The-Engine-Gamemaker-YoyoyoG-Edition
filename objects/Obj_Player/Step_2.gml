/// @description Handle player collision

// Check block collision
with (Obj_Block) {
	if (object_is_ancestor(object_index,Obj_Platform) || object_index == Obj_Platform)
		continue;

	with (other) {
		if (place_meeting(x,y,other)) {
			x = xprevious;
			y = yprevious;
	
			// Check for horizontal collisions
			if (!place_free(x+hspeed,y)) {
				if (hspeed <= 0) {
					move_contact_solid(180,abs(hspeed));
			    } else {
					move_contact_solid(0,abs(hspeed));
				}
		
			    hspeed = 0;
			}

			// Check for vertical collisions
			if (!place_free(x,y+vspeed)) {
				if(vspeed <= 0) {
					move_contact_solid(90,abs(vspeed));
		
					if (global.grav == -1) {
						djump = 1;
					}
			    } else {
					move_contact_solid(270,abs(vspeed));
		
					if (global.grav == 1) {
						djump = 1;
					}
				}
	
			    vspeed = 0;
			}

			// Check for diagonal collisions
			if (!place_free(x+hspeed,y+vspeed)) {
				hspeed = 0;
			}
	
			x += hspeed;
			y += vspeed;
		}
	}
}

// Check platform collision
with (Obj_Platform) {
	with (other) {
		if (place_meeting(x,y,other)) {
			if (global.grav == 1) { // Check if on top of the platform (when right-side up)
			    if (y-vspeed/2 <= other.y) {
			        if (other.vspeed >= 0) {
			            y = other.y-9; // Snap to the platform
			            vspeed = other.vspeed;
			        }
        
			        onPlatform = true;
			        djump = 1;
			    }
			} else { // Check if on top of the platform (when flipped)
			    if (y-vspeed/2 >= other.y+other.sprite_height-1) {
			        if (other.yspeed <= 0) {
			            y = other.y+other.sprite_height+8; // Snap to the platform
			            vspeed = other.yspeed;
			        }
        
			        onPlatform = true;
			        djump = 1;
			    }
			}
		}
	}
}

// Check save collision
with (Obj_Save) {
	event_user(1);
}

// Check water collision
with (Obj_WaterParent) {
	event_user(0);
}

// Check if player left the room and update player sprite (if set to)
if ((x < 0 || x > room_width || y < 0 || y > room_height) && global.edgeDeath) {
    Player_Kill();
}

// Update player sprite
if (PLAYER_ANIMATION_FIX) {
	// Block/vine checks
	var notOnBlock = (place_free(x,y+(global.grav)));
	var onVineR = (place_meeting(x+1,y,Obj_WalljumpR) && notOnBlock);
	var onVineL = (place_meeting(x-1,y,Obj_WalljumpL) && notOnBlock);
	
	if (!onVineR && !onVineL) { // Not touching any vines
		if (onPlatform || !notOnBlock) { // Standing on something
			// Check if moving left/right
			var L = (Input_Check(global.leftButton) || (DIRECTIONAL_TAP_FIX && Input_CheckPressed(global.leftButton)));
			var R = (Input_Check(global.rightButton) || (DIRECTIONAL_TAP_FIX && Input_CheckPressed(global.rightButton)));
			
			if ((L || R) && !frozen) {
				sprite_index = Spr_PlayerRun;
				image_speed = 0.5;
			} else {
				sprite_index = Spr_PlayerIdle;
				image_speed = 0.2;
			}
		} else { // In the air
			if ((vspeed * global.grav) < 0) {
				sprite_index = Spr_PlayerJump;
				image_speed = 0.5;
			} else {
				sprite_index = Spr_PlayerFall;
				image_speed = 0.5;
			}
		}
	} else { // Touching a vine
		sprite_index = Spr_PlayerSlide;
		image_speed = 0.5;
	}
}