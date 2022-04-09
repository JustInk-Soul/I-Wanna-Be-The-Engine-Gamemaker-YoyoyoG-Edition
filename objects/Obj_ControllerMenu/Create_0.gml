/// @description Initialize variables

buttonSelect = 0; // Sets which button is currently selected

xSelector = 120; // Sets where to draw the menu text on the x axis
ySelector = 29; // Sets where to draw the menu text on the y axis
xSeperation = 560; // Sets how far to separate the button name from the button value
ySeperation = 40; // Sets how far each option is from each other

settingButton = false; // Sets whether or not a button is currently getting set
resetPrompt = false; // Sets whether to show the message that controls were reset

/*strSelect[0] = "Controller Index";
strSelect[1] = "Left Button";
strSelect[2] = "Right Button";
strSelect[3] = "Up Button";
strSelect[4] = "Down Button";
strSelect[5] = "Jump Button";
strSelect[6] = "Shoot Button";
strSelect[7] = "Restart Button";
strSelect[8] = "Skip Button";
strSelect[9] = "Suicide Button";
strSelect[10] = "Pause Button";
strSelect[11] = "Reset Controls";*/
strSelect[0] = "Controller Index";
strSelect[INPUT.LEFT+1] = "Left Button";
strSelect[INPUT.RIGHT+1] = "Right Button";
strSelect[INPUT.UP+1] = "Up Button";
strSelect[INPUT.DOWN+1] = "Down Button";
strSelect[INPUT.JUMP+1] = "Jump Button";
strSelect[INPUT.SHOOT+1] = "Shoot Button";
strSelect[INPUT.RESTART+1] = "Restart Button";
strSelect[INPUT.SKIP+1] = "Skip Button";
strSelect[INPUT.SUICIDE+1] = "Suicide Button";
strSelect[INPUT.PAUSE+1] = "Pause Button";
strSelect[11] = "Reset Controls";
// Get current control strings
strButton[0] = string(global.controllerIndex);
strButton[INPUT.LEFT+1] = Input_GetString(global.leftButton[1]);
strButton[INPUT.RIGHT+1] = Input_GetString(global.rightButton[1]);
strButton[INPUT.UP+1] = Input_GetString(global.upButton[1]);
strButton[INPUT.DOWN+1] = Input_GetString(global.downButton[1]);
strButton[INPUT.JUMP+1] = Input_GetString(global.jumpButton[1]);
strButton[INPUT.SHOOT+1] = Input_GetString(global.shootButton[1]);
strButton[INPUT.RESTART+1] = Input_GetString(global.restartButton[1]);
strButton[INPUT.SKIP+1] = Input_GetString(global.skipButton[1]);
strButton[INPUT.SUICIDE+1] = Input_GetString(global.suicideButton[1]);
strButton[INPUT.PAUSE+1] = Input_GetString(global.pauseButton[1]);
strButton[11] = "";
/*strButton[0] = string(global.controllerIndex);
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
strButton[11] = "";*/

if (global.controllerIndex == -1) {
	strButton[0] = "Disabled";
}

// Stores the image index of the menu sprite
playerIndex = 0;
