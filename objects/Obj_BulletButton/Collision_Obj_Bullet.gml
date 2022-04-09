/// @description Set trigger

if (image_index == 0) {
    image_index = 1;
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
				global.saveSwitchs[tri] = true;
				Save_Game(false);
			}
		}
	}
	else
	{
		global.trigger[trg] = true;
		if(tri>0)
		{
			global.switchs[tri] = true;
			global.saveSwitchs[tri] = true;
			Save_Game(false);
		}
	}
}