/// @description Collect this item

global.bossItem[itemNum] = true;

audio_play_sound(Snd_BlockChange,0,false);
instance_destroy();