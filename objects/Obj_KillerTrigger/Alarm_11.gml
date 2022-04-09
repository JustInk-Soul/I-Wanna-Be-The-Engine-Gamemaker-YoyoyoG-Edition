/// @description Init For Someting
spr=global.theme[spr_ind];
if(sprite_exists(spr))
{
	sprite_index = spr;
}
/*if(!sprite_exists(spr))
{
	spr = sprite_index;
}*/
if(spro!=-1 or sprox != sprite_xoffset or sproy != sprite_yoffset)
{
	sprite_change = true;
	spr = sprite_duplicate(sprite_index);
	if(spro !=-1)
	{
		switch(spro)
		{
			case 0:
				sprite_set_offset(spr,0,0);
				break;
			case 1:
				sprite_set_offset(spr,sprite_get_width(spr)/2,0);
				break;
			case 2:
				sprite_set_offset(spr,sprite_get_width(spr),0);
				break;
			case 3:
				sprite_set_offset(spr,0,sprite_get_height(spr)/2);
				break;
			case 4:
				sprite_set_offset(spr,sprite_get_width(spr)/2,sprite_get_height(spr)/2);
				break;
			case 5:
				sprite_set_offset(spr,sprite_get_width(spr),sprite_get_height(spr)/2);
				break;
			case 6:
				sprite_set_offset(spr,0,sprite_get_height(spr));
				break;
			case 7:
				sprite_set_offset(spr,sprite_get_width(spr)/2,sprite_get_height(spr));
				break;
			case 8:
				sprite_set_offset(spr,sprite_get_width(spr),sprite_get_height(spr));
				break;
				
		}
	}
	else
	{
		sprite_set_offset(spr,sprox,sproy);
	}
}
