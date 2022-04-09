/// @description Reset trigger

if(audio_exists(snd))
{
	if(audio_is_playing(snd))
	{
		audio_stop_sound(snd);
	}
}
if(trg>0)
{
	global.trigger[trg] = false;
}
