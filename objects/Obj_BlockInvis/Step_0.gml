/// @description Check if the player is near

if (!visible && distance_to_object(Obj_Player) <= 1) {
    audio_play_sound(Snd_BlockChange,0,false);
    visible = true;
}