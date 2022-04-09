/// @description Give player a djump

if (visible) {
    with (Obj_Player) {
        djump = 1;
	}
    
    visible = false;
    alarm[0] = refreshTime;
}