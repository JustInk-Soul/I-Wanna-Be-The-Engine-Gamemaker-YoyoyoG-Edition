/// @description Check for button inputs

// Animate menu sprite
playerIndex = (playerIndex + 1/5) mod 4;

// Check for button inputs
if (!settingButton) { // Check if we're currently setting a button bind
    if (Input_CheckPressed(global.menuUpButton)) { // Move up in the menu
        audio_play_sound(MENU_SOUND,0,false);
        buttonSelect -= 1;
        if (buttonSelect < 0) {
            buttonSelect = 11;
		}
    } else if (Input_CheckPressed(global.menuDownButton)) { // Move down in the menu
        audio_play_sound(MENU_SOUND,0,false);
        buttonSelect += 1;
        if (buttonSelect > 11) {
            buttonSelect = 0;
		}
    } else if (Input_CheckPressed(global.menuBackButton)) { // Save changes and go back to the options menu
        Save_Config();
        instance_create_layer(x,y,layer,Obj_OptionsMenu);
        instance_destroy();
    } else if (Input_CheckPressed(global.menuAcceptButton)) {  // Select current option
        if (buttonSelect != 0) {
            if (buttonSelect != 11) { // Set the selected button
                settingButton = true;
            } else { // Reset to default controls
                global.leftButton[1] = gp_padl;
                global.rightButton[1] = gp_padr;
                global.upButton[1] = gp_padu;
                global.downButton[1] = gp_padd;
                global.jumpButton[1] = gp_face1;
                global.shootButton[1] = gp_face3;
                global.restartButton[1] = gp_face4;
                global.skipButton[1] = gp_face2;
                global.suicideButton[1] = gp_select;
                global.pauseButton[1] = gp_start;
                
				// Show control reset text
                resetPrompt = true;
                alarm[0] = 60;
            }
        }
    }
    
    // Change controller index
    if (buttonSelect == 0) {
        if (Input_CheckPressed(global.menuRightButton)) {
            global.controllerIndex += 1;
            if (global.controllerIndex > 11) {
                global.controllerIndex = -1;
			}
        } else if (Input_CheckPressed(global.menuLeftButton)) {
            global.controllerIndex -= 1;
            if (global.controllerIndex < -1) {
                global.controllerIndex = 11;
			}
        }
    }
} else {
    var buttonChange = Input_AnyControllerButtonPressed(); // Get any buttons currently getting pressed
	
    if (buttonChange != -1) { // Check if a button is being pressed and if it is, store that button
		// Set the currently pressed button to whichever button is selected
		switch (buttonSelect) {
			case 1:
				global.leftButton[1] = buttonChange;
				break;
			case 2:
				global.rightButton[1] = buttonChange;
				break;
			case 3:
				global.upButton[1] = buttonChange;
				break;
			case 4:
				global.downButton[1] = buttonChange;
				break;
			case 5:
				global.jumpButton[1] = buttonChange;
				break;
			case 6:
				global.shootButton[1] = buttonChange;
				break;
			case 7:
				global.restartButton[1] = buttonChange;
				break;
			case 8:
				global.skipButton[1] = buttonChange;
				break;
			case 9:
				global.suicideButton[1] = buttonChange;
				break;
			case 10:
				global.pauseButton[1] = buttonChange;
				break;
		}
        
        settingButton = false;
    } else if (keyboard_check_pressed(vk_anykey)) { //Iif a keyboard key was pressed, exit prompt
        settingButton = false;
    }
}

// Update current control strings
strButton[0] = string(global.controllerIndex);
strButton[1] = Input_GetControllerString(global.leftButton[1]);
strButton[2] = Input_GetControllerString(global.rightButton[1]);
strButton[3] = Input_GetControllerString(global.upButton[1]);
strButton[4] = Input_GetControllerString(global.downButton[1]);
strButton[5] = Input_GetControllerString(global.jumpButton[1]);
strButton[6] = Input_GetControllerString(global.shootButton[1]);
strButton[7] = Input_GetControllerString(global.restartButton[1]);
strButton[8] = Input_GetControllerString(global.skipButton[1]);
strButton[9] = Input_GetControllerString(global.suicideButton[1]);
strButton[10] = Input_GetControllerString(global.pauseButton[1]);
strButton[11] = "";

if (global.controllerIndex == -1) {
	strButton[0] = "Disabled";
}