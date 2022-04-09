/// @description Handle player movement

// Check left/right button presses
var L = (Input_Check(global.leftButton) || (DIRECTIONAL_TAP_FIX && Input_CheckPressed(global.leftButton)));
var R = (Input_Check(global.rightButton) || (DIRECTIONAL_TAP_FIX && Input_CheckPressed(global.rightButton)));

var h = 0; //Keeps track if the player is moving left/right

if (!frozen) { // Don't move if frozen
    if (R) {
        h = 1;
    } else if (L) {
        h = -1;
	}
}

// Check if on a slip block
var slipBlockTouching = instance_place(x,y+(global.grav),Obj_SlipBlock);

// Vine checks
var notOnBlock = (place_free(x,y+(global.grav)));
var onVineR = (place_meeting(x+1,y,Obj_WalljumpR) && notOnBlock);
var onVineL = (place_meeting(x-1,y,Obj_WalljumpL) && notOnBlock);

if (h != 0) { // Player is moving
	if (!onVineR && !onVineL) { // Make sure we're not currently on a vine
		xScale = h; // Set the direction the player is facing
	}
	
	if ((h == -1 && !onVineR) || (h == 1 && !onVineL)) { // Make sure we're not moving off a vine (that's handled later)
	    if (slipBlockTouching == noone) { // Not touching a slip block, move immediately at full speed
	        hspeed = maxHSpeed * h;
	    } else { // Touching a slip block, use acceleration
			hspeed += (slipBlockTouching.slip) * h;
		
			if (abs(hspeed) > maxHSpeed) {
				hspeed = maxHSpeed * h;
			}
	    }
	}
	
    sprite_index = Spr_PlayerRun;
	image_speed = 0.5;
} else { // Player is not moving
    if (slipBlockTouching == noone) { // Not touching a slip block, stop immediately
        hspeed = 0;
    } else { // Touching a slip block, slow down
        if (hspeed > 0) {
            hspeed -= slipBlockTouching.slip;
            
            if (hspeed <= 0) {
                hspeed = 0;
			}
        } else if (hspeed < 0) {
            hspeed += slipBlockTouching.slip;
            
            if (hspeed >= 0) {
                hspeed = 0;
			}
        }
    }
  
    sprite_index = Spr_PlayerIdle;
	image_speed = 0.2;
}

// Check if standing on a platform
if (!onPlatform) {
    if ((vspeed * global.grav) < -0.05) {
		sprite_index = Spr_PlayerJump;
    } else if ((vspeed * global.grav) > 0.05) {
		sprite_index = Spr_PlayerFall;
	}
} else {
    if (!place_meeting(x,y+(4*global.grav),Obj_Platform)) {
		onPlatform = false;
	}
}

// Check if on a slide block
var slideBlockTouching = instance_place(x,y+(global.grav),Obj_SlideBlock);

if (slideBlockTouching != noone) { // On a slide block, start moving with it
    hspeed += slideBlockTouching.slide;
}

// Check if moving faster vertically than max speed
if (abs(vspeed) > maxVSpeed) {
	vspeed = sign(vspeed) * maxVSpeed;
}

// Check buttons for player actions
if (!frozen) { // Check if frozen before doing anything
    if (Input_CheckPressed(global.jumpButton)) {
        Player_Jump();
	}
    if (Input_CheckReleased(global.jumpButton)) {
        Player_VJump();
	}
    if (Input_CheckPressed(global.shootButton)) {
        Player_Shoot();
	}
    if (Input_CheckPressed(global.suicideButton)) {
        Player_Kill();
	}
}

// A/D align
if (global.adAlign && place_meeting(x,y+(global.grav),Obj_Block) && !frozen) {
    if (Input_CheckPressed(global.alignLeftButton)) {
		hspeed -= 1;
	}
    if (Input_CheckPressed(global.alignRightButton)) {
		hspeed += 1;
	}
}

// Handle walljumps
if (onVineL || onVineR) {
    if (onVineR) {
        xScale = -1;
    } else {
        xScale = 1;
	}
    
    vspeed = 2 * global.grav;
    sprite_index = Spr_PlayerSlide;
	image_speed = 0.5;
    
    // Check if moving away from the vine
	if (onVineL && Input_CheckPressed(global.rightButton)) || (onVineR && Input_CheckPressed(global.leftButton)) {
        if (Input_Check(global.jumpButton)) { // Jumping off vine
            if (onVineR) {
                hspeed = -15;
            } else {
                hspeed = 15;
			}
            
            vspeed = -9 * global.grav;
            audio_play_sound(Snd_WallJump,0,false);
            sprite_index = Spr_PlayerJump;
        } else { // Moving off vine
			if (onVineR) {
                hspeed = -3;
            } else {
                hspeed = 3;
			}
            
            sprite_index = Spr_PlayerFall;
        }
    }
}


// Handle slopes
if (instance_exists(Obj_Slope) && hspeed != 0) { // Make sure slopes exist in the current room and the player is moving horitontally before doing checks
    var moveLimit = abs(hspeed); // Sets how far the player can go up/down to snap onto a slope, this can be increased to make the player able to run over steeper slopes (ie setting it to abs(hspeed)*2 allows the player to run over slopes twice as steep)
    
    var slopeCheck; // Keeps track of whether we're still checking the current slope loop
    var hTest; // Keeps track of how far horizontally we're currently checking
    var vTest; // Keeps track of how far vertically we're currently checking
    
    // Check for falling onto a slope
    if (place_meeting(x+hspeed,y+vspeed+gravity,Obj_Slope) && (vspeed+gravity)*global.grav > 0 && notOnBlock) {
        // Store previous coordinates in case snapping onto the slope fails
		var xLast = x;
        var yLast = y;
        var hLast = hspeed;
        var vLast = vspeed;
		
		vspeed += gravity; // Apply gravity to current vspeed to check where the player will be
        
        x += hspeed; // Move the player to the next position horizontally
        hspeed = 0;
        
		// Snap the player to any solids in the way
        if (!place_free(x,y+vspeed)) {
            if (global.grav == 1) {
                move_contact_solid(270,abs(vspeed));
            } else {
                move_contact_solid(90,abs(vspeed));
			}
            vspeed = 0;
        }
        
        y += vspeed; // Move the player to the next position vertically
        
        if (!place_free(x,y+(global.grav)) && place_free(x,y)) { // Check if we snapped onto the slope properly
            djump = 1;
            notOnBlock = false;
        } else { // Did not snap onto the slope, return to previous position
            x = xLast;
            y = yLast;
            hspeed = hLast;
            vspeed = vLast;
        }
    }
    
    // Check for moving down a slope
    if (!notOnBlock) {
        var onSlope = (place_meeting(x,y+(global.grav),Obj_Slope)); // Check if we're standing on slope, treat normal blocks the same as slopes if we are
        
        slopeCheck = true;
        hTest = hspeed;
        
        while (slopeCheck) {
            vTest = 0;
            // Check how far we should move down for this check
            while ((!place_meeting(x+hTest,y-vTest+(global.grav),Obj_Slope) || (onSlope && !place_meeting(x+hTest,y-vTest+(global.grav),Obj_Block))) && (vTest*global.grav > -floor(moveLimit*(hTest/hspeed)))) {
                vTest -= global.grav;
            }
            
            // Check if we there's a slope close enough to fall down onto
            if (place_meeting(x+hTest,y-vTest+(global.grav),Obj_Slope) || (onSlope && place_meeting(x+hTest,y-vTest+(global.grav),Obj_Block))) {
                if (vTest != 0 && !place_meeting(x+hTest,y-vTest,Obj_Block)) { // Check if we are moving and not stuck in any blocks
                    y -= vTest;
                    
                    x += hTest;
                    hspeed = 0;
                    
                    slopeCheck = false;
                } else { // Did not snap onto the slope, lower horizontal movement and check again
                    if (hTest > 0) {
                        hTest -= 1;
                        if (hTest <= 0) {
                            slopeCheck = false;
						}
                    } else if (hTest < 0) {
                        hTest += 1;
                        if (hTest >= 0) {
                            slopeCheck = false;
						}
                    } else {
                        slopeCheck = false;
                    }
                }
            } else { //Not close enough to any slopes, cancel check
                slopeCheck = false;
            }
        }
    }
    
    // Check for moving up a slope
    if (place_meeting(x+hspeed,y,Obj_Slope)) {
        slopeCheck = true;
        hTest = hspeed;
        
        while (slopeCheck) {
            vTest = 0;
            
            // Check how far we have to move up for this check
            while (place_meeting(x+hTest,y-vTest,Obj_Slope) && vTest*global.grav < floor(moveLimit*(hTest/hspeed))) {
                vTest += global.grav;
            }
            
            // Check if we can move without hitting any solids
            if (place_free(x+hTest,y-vTest)) {
                y -= vTest;
                
                x += hTest;
                hspeed = 0;
                
                slopeCheck = false;
            } else { // Something is in the way, lower horizontal movement and check again
                if (hTest > 0) {
                    hTest -= 1;
                    if (hTest <= 0) {
                        slopeCheck = false;
					}
                } else if (hTest < 0) {
                    hTest += 1;
                    if (hTest >= 0) {
                        slopeCheck = false;
					}
                } else {
                    slopeCheck = false;
                }
            }
        }
    }
    
    // Set the xprevious/yprevious coordinates to the current x/y for future solid collisions
    xprevious = x;
    yprevious = y;
}