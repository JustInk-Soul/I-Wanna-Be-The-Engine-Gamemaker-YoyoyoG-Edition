/// @description Set trigger

if (image_index == 0) {
    image_index = 1;
    if(key>0)
	{
		if(global.trigger[key])
		{
			global.trigger[trg] = true;
			if(tri>0)
			{
				global.switchs[tri] = true;
			}
		}
	}
	else
	{
		global.trigger[trg] = true;
		if(tri>0)
		{
			global.switchs[tri] = true;
		}
	}
}