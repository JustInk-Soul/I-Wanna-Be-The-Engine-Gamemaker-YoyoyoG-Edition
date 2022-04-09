/// @description Check for button inputs

// Animate select sprites
appleIndex = (appleIndex + 1/15) mod 2;
playerIndex = (playerIndex + 1/5) mod 4;

// Check for button inputs
if (Input_CheckPressed(global.menuOptionsButton)) { // Go to the options menu
    global.menuSelectPrev[0] = fileSelect;
	room_goto(rOptions);
} else {
    if (!difSelectMode) {
        if (Input_CheckPressed(global.menuLeftButton)) { // Move left in the menu
            audio_play_sound(MENU_SOUND,0,false);
            fileSelect -= 1;
            if (fileSelect < 0) {
                fileSelect = 2;
			}
        } else if (Input_CheckPressed(global.menuRightButton)) { // Move right in the menu
            audio_play_sound(MENU_SOUND,0,false);
            fileSelect += 1;
            if (fileSelect > 2) {
                fileSelect = 0;
			}
        } else if (Input_CheckPressed(global.menuBackButton)) { // Go back to the title een
            global.menuSelectPrev[0] = 0;
			room_goto(rTitle);
        } else if (Input_CheckPressed(global.menuAcceptButton)) { // Accepted a file, go to difficulty select
            if (DIFFICULTY_MENU_MODE == 0) { // Use the difficulty select room to select difficulty
                global.saveNum = fileSelect + 1;
                room_goto(rDifficultySelect);
            } else { // Use the menu to select difficulty
                difSelectMode = true;
                if (exists[fileSelect]) { // Check if a save exists in the current slot
                    difSelect = -1; // Default to load game
                } else {
                    difSelect = 0; // Default to medium
				}
            }
        }
    } else {
        if (!warnText) {
            if (Input_CheckPressed(global.menuLeftButton)) { // Move left in the difficulty menu
                audio_play_sound(MENU_SOUND,0,false);
                difSelect -= 1;
                if ((difSelect < -1) || (difSelect == -1 && !exists[fileSelect])) {
                    difSelect = 3;
				}
            }
            else if (Input_CheckPressed(global.menuRightButton)) { // Move right in the difficulty menu
                audio_play_sound(MENU_SOUND,0,false);
                difSelect += 1;
                if (difSelect > 3) {
                    if (exists[fileSelect]) {
                        difSelect = -1;
                    } else {
                        difSelect = 0;
					}
                }
            } else if (Input_CheckPressed(global.menuBackButton)) { // Back out of difficulty select mode
                difSelectMode = false;
            } else if (Input_CheckPressed(global.menuAcceptButton)) { // Choose the current difficulty
                global.saveNum = fileSelect + 1;
                
                if (difSelect == -1) { // Load game
                    if (file_exists("Data\\save"+string(global.saveNum))) {
                        Load_Game(true);
					}
                } else { // Start new game
                    if (!file_exists("Data\\save"+string(global.saveNum))) { // No file exists currently, start game
                        global.gameStarted = true; // Sets game in progress (enables saving, restarting, etc.)
                        global.autosave = true;
                        
                        global.difficulty = difSelect;
                        
                        room_goto(global.startRoom);
                    } else { // File exists, show warning text before starting a new game
                        warnText = true;
                        warnSelect = true;
                    }
                }
            }
        } else {
            if (Input_CheckPressed(global.menuLeftButton)) { // Toggle the warning text option
                audio_play_sound(MENU_SOUND,0,false);
                warnSelect = !warnSelect;
            } else if (Input_CheckPressed(global.menuRightButton)) {  // Toggle the warning text option
                audio_play_sound(MENU_SOUND,0,false);
                warnSelect = !warnSelect;
            } else if (Input_CheckPressed(global.menuBackButton)) { // Back out of warning text
                warnText = false;
            } else if (Input_CheckPressed(global.menuAcceptButton)) { // Selected the current option
                if (warnSelect) { // Start new game
                    if (file_exists("Data\\save"+string(global.saveNum))) {
                        file_delete("Data\\save"+string(global.saveNum)); // Delete current save file
					}
					
					global.gameStarted = true; // Sets game in progress (enables saving, restarting, etc.)
                    global.autosave = true;
                    
                    global.difficulty = difSelect;
                    
                    room_goto(global.startRoom);
                } else { // Back out of warning text
                    warnText = false;
                }
            }
        }
    }
}