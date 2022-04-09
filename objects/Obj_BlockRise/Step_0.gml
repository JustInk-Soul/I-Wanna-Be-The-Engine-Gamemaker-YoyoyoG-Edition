/// @description Check if near player and move

if (yspeed == 0 && instance_exists(Obj_Player)) {
    if (place_meeting(x,y-Obj_Player.vspeed-(global.grav),Obj_Player)) {
        yspeed = -2; // Touching the player, start rising
    }
}

event_inherited(); // Movement checks