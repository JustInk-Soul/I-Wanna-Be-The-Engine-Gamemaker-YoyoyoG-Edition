/// @description Initialize variables

keySelect = 0; // Sets which key is currently selected

xSelector = 120; // Sets where to draw the menu text on the x axis
ySelector = 53; // Sets where to draw the menu text on the y axis
xSeperation = 560; // Sets how far to separate the key name from the key value
ySeperation = 40; // Sets how far each option is from each other

settingKey = false; // Sets whether or not a key is currently getting set
resetPrompt = false; // Sets whether to show the message that controls were reset

strSelect[INPUT.LEFT] = "Left Button";
strSelect[INPUT.RIGHT] = "Right Button";
strSelect[INPUT.UP] = "Up Button";
strSelect[INPUT.DOWN] = "Down Button";
strSelect[INPUT.JUMP] = "Jump Button";
strSelect[INPUT.SHOOT] = "Shoot Button";
strSelect[INPUT.RESTART] = "Restart Button";
strSelect[INPUT.SKIP] = "Skip Button";
strSelect[INPUT.SUICIDE] = "Suicide Button";
strSelect[INPUT.PAUSE] = "Pause Button";
strSelect[10] = "Reset Controls";

// Get current control strings
strKey[INPUT.LEFT] = Input_GetString(global.leftButton[0]);
strKey[INPUT.RIGHT] = Input_GetString(global.rightButton[0]);
strKey[INPUT.UP] = Input_GetString(global.upButton[0]);
strKey[INPUT.DOWN] = Input_GetString(global.downButton[0]);
strKey[INPUT.JUMP] = Input_GetString(global.jumpButton[0]);
strKey[INPUT.SHOOT] = Input_GetString(global.shootButton[0]);
strKey[INPUT.RESTART] = Input_GetString(global.restartButton[0]);
strKey[INPUT.SKIP] = Input_GetString(global.skipButton[0]);
strKey[INPUT.SUICIDE] = Input_GetString(global.suicideButton[0]);
strKey[INPUT.PAUSE] = Input_GetString(global.pauseButton[0]);
strKey[10] = "";

// Stores the image index of the menu sprite
playerIndex = 0;