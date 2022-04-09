/// @description Game checks

// Set texture filtering depending on what the current smoothing setting is
gpu_set_texfilter(global.smoothingMode);

// Controller checks
if (CONTROLLER_ENABLED && global.controllerIndex != -1) {
    if (!global.controllerMode) { // Check if we should switch to controller mode
        if (keyboard_check_pressed(vk_anykey)) {
            global.controllerDelay = -1;
        } else if (Input_AnyControllerButtonPressed() != -1) {
            if (global.controllerDelay == -1) {
                global.controllerDelay = CONTROLLER_DELAY_LENGTH; // Controller button pressed while in keyboard mode, set delay to switch
			}
        }
    } else { // Check if we should switch to keyboard mode
        if (keyboard_check_pressed(vk_anykey)) {
            if (global.controllerDelay == -1) {
                global.controllerDelay = CONTROLLER_DELAY_LENGTH; // Keyboard button pressed while in controller mode, set delay to switch
			}
        } else if (Input_AnyControllerButtonPressed() != -1) {
            global.controllerDelay = -1;
        }
    }
    
    if (global.controllerDelay != -1) { // Check if delay for switching between keyboard/controller is active
        if (global.controllerDelay == 0) { // Delay over, toggle controller mode
            global.controllerMode = !global.controllerMode;
            global.controllerDelay = -1;
        } else {
            global.controllerDelay -= 1;
        }
    }
}

if (global.gameStarted) {
    // Handle pausing
    if (global.pauseDelay <= 0) { // Check if pause delay is active
        if (Input_CheckPressed(global.pauseButton)) {
            if (!global.gamePaused) { // Game is currently not paused, pause the game
                if (!global.noPause) {
                    global.gamePaused = true; // Set the game to paused
                    global.pauseDelay = PAUSE_DELAY_LENGTH; // Set pause delay
                    
                    instance_deactivate_all(true); // Deactivate everything
					
					// Copy the current een to a new sprite
					global.pauseSpr_ = sprite_create_from_surface(application_surface,0,0,surface_get_width(application_surface),surface_get_height(application_surface),false,false,0,0);
					
					// Disable automatically drawing the application surface since the pause een will be over it
					application_surface_draw_enable(false);
                }
            } else { // Game is currently paused, unpause the game
                global.gamePaused = false; // Set the game to unpaused
                global.pauseDelay = PAUSE_DELAY_LENGTH; // Set pause delay
                
                instance_activate_all(); // Reactivate everything
                
				// Delete pause een sprite
				sprite_delete(global.pauseSpr_);
				
				// Enable automatically drawing the application surface
				application_surface_draw_enable(true);
                
                Save_Config(); // Save the config in case the volume levels were changed
                
                io_clear(); // Clear input states to prevent possible pause strats/exploits
            }
        }
    } else {
        global.pauseDelay -= 1;
    }
    
    if (!global.gamePaused) { // Make sure the game is currently unpaused
        // Check for restart button
		if (Input_CheckPressed(global.restartButton)) {
            // Stop death sound/music
            audio_stop_sound(global.deathSound);
            audio_stop_sound(global.gameOverMusic);
            
            // Resume room music
            audio_resume_sound(global.currentMusic);
            
            // Return to old gain if music is being faded out
            if (global.musicFading) {
                global.musicFading = false;
                audio_sound_gain(global.currentMusic,global.currentGain,0);
                alarm[0] = -1; // Reset alarm that pauses music
            }
            
            Save_Game(false); // Save deaths/time
            Load_Game(false); // Load the game
        }
        
		// Increment timer
        if (TIME_WHEN_DEAD || instance_exists(Obj_Player)) {
            global.timeMicro += delta_time;
            global.time += global.timeMicro div 1000000;
            global.timeMicro = global.timeMicro mod 1000000;
        }
    } else {
        // Game is paused, check for volume controls
		if (Input_Check(global.upButton)) { // Raise volume
            if (global.volumeLevel < 100) {
                global.volumeLevel += 1;
			}
			audio_master_gain(global.volumeLevel/100); // Set master gain
        } else if (Input_Check(global.downButton)) { // Lower volume
            if (global.volumeLevel > 0) {
                global.volumeLevel -= 1;
			}
			audio_master_gain(global.volumeLevel/100); // Set master gain
        }
        
    }
    
    Window_SetCaption(); // Keep the window caption updated
}

// Check debug keys
if (global.debugMode && global.gameStarted && !global.gamePaused) {
    // Drag player with mouse
	if (keyboard_check(vk_tab)) {
        with (Obj_Player) {
            x = mouse_x;
            y = mouse_y;
        }
    }
	
	// Toggle debug overlay
    if (keyboard_check_pressed(vk_backspace)) {
        global.debugOverlay = !global.debugOverlay;
    }
	
	// Save game
    if (keyboard_check_pressed(vk_insert)) {
        with (Obj_Player) {
            Save_Game(true);
            audio_play_sound(Snd_Item,0,false);
        }
    }
	
	// Toggle showing the player's hitbox
    if (keyboard_check_pressed(vk_delete)) {
        global.debugShowHitbox = !global.debugShowHitbox;
    }
	
	// Toggle god mode
    if (keyboard_check_pressed(vk_home)) {
        global.debugNoDeath = !global.debugNoDeath;
    }
	
	// Toggle infinite jump
    if (keyboard_check_pressed(vk_end)) {
        global.debugInfJump = !global.debugInfJump;
    }
	
	// Go to next room
    if (keyboard_check_pressed(vk_pageup) && room != room_last) {
        with (Obj_Player) {
            instance_destroy();
		}
        room_goto_next();
    }
	
	// Go to previous room
    if (keyboard_check_pressed(vk_pagedown) && room != room_first) {
        with (Obj_Player) {
            instance_destroy();
		}
        room_goto_previous();
    }
}

// Check to show debug visuals on the player
if (global.debugVisuals) {
    with (Obj_Player) {
        if (global.debugNoDeath) { // Make the player slightly transparent when god mode is on
            image_alpha = 0.7;
        } else {
            image_alpha = 1;
		}
        
        if (global.debugInfJump) { // Make the player turn blue when infinite jump is on
            image_blend = c_blue;
        } else {
            image_blend = c_white;
		}
    }
}

// Check function keys

// End game
if (keyboard_check_pressed(vk_escape)) {
    game_end();
	exit;
}

// Restart game
if (keyboard_check_pressed(vk_f2)) {
    game_restart();
    exit;
}

// Toggle fulleen mode
if (keyboard_check_pressed(vk_f4) && !global.gamePaused) {
    global.fulleenMode = !global.fulleenMode;
    window_set_fulleen(global.fulleenMode);
    
    Save_Config(); // Save fulleen setting
}

// Toggle music
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("M")) && !global.gamePaused) {
    Music_Toggle();
    
    Save_Config(); // Save mute setting
}