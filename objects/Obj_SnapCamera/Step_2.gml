/// @description Snap camera to the player

if (instance_exists(Obj_Player)) {
	var xFollow = Obj_Player.x;
    var yFollow = Obj_Player.y;
    
    if (!leaveRoom) {
        xFollow = clamp(xFollow,0,room_width-1); 
        yFollow = clamp(yFollow,0,room_height-1);   
    }
	
	xFollow = floor(xFollow/view_wport[0])*view_wport[0];
    yFollow = floor(yFollow/view_hport[0])*view_hport[0];
	
	camera_set_view_pos(view_camera[0],xFollow,yFollow);
}