/// @description Set trigger
//global.buttons
if(!triggered)
{
	if(loc>0)
	{
		if(!global.trigger[loc])
		{
			if(key>0)
			{
				if(global.trigger[key])
				{
					if(trg>0)
					{
						global.trigger[trg] = true;
					}
					if(tri>0)
					{
						global.switchs[tri] = true;
					}
					triggered=true;
					if(audio_exists(snd))
					{
						audio_play_sound(snd,0,false);
					}
				}
			}
			else
			{
				if(trg>0)
				{
					global.trigger[trg] = true;
				}
				if(tri>0)
				{
					global.switchs[tri] = true;
				}
				triggered=true;
				if(audio_exists(snd))
				{
					audio_play_sound(snd,0,false);
				}
			}
		}
	}
	else
	{
		if(key>0)
		{
			if(global.trigger[key])
			{
				if(trg>0)
				{
					global.trigger[trg] = true;
				}
				if(tri>0)
				{
					global.switchs[tri] = true;
				}
				triggered=true;
				if(audio_exists(snd))
				{
					audio_play_sound(snd,0,false);
				}
			}
		}
		else
		{
			if(trg>0)
			{
				global.trigger[trg] = true;
			}
			if(tri>0)
			{
				global.switchs[tri] = true;
			}
			triggered=true;
			if(audio_exists(snd))
			{
				audio_play_sound(snd,0,false);
			}
		}
	}
}
