/// @description Check if text should be showing

if (place_meeting(x,y,Obj_Player)) {
    if (Input_CheckPressed(global.upButton)) {
        showText = true;
	}
} else {
    showText = false;
}