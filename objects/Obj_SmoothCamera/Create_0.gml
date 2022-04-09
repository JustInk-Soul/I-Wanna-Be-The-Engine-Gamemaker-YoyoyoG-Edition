/// @description Initalize variables

snapDiv = 4; // Determines how fast the camera snaps to the player, higher numbers follow the player slower (can be changed in creation code)

// Snap to the player when spawning
if (instance_exists(Obj_Player)) {
    x = Obj_Player.x;
    y = Obj_Player.y;
}

camera_set_view_target(view_camera[0],id); // Set the view camera to follow this object