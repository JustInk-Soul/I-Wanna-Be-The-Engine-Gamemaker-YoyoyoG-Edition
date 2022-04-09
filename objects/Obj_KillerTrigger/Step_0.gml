/// @description Check if triggered
sprite_index=spr;
if(!triggered) 
{
	hpoint=x+hp;
	vpoint=y+vp;
	if(trg > 0) 
	{
		if(global.trigger[trg])
		{
			if(tri>0)
			{
				if(global.switchs[tri])
				{
					triggered = true;
					event_user(0);
				}
			}
			else
			{
				triggered = true;
				event_user(0);
			}	
		}
	}
	else
	{
		if(tri>0)
		{
			if(global.switchs[tri])
			{
				triggered = true;
				event_user(0);
			}
		}
		else
		{
			triggered = true;
			event_user(0);
		}
	}
}
else
{
	//Move
	switch(mov)
	{
		case 1:
			if(x>hpoint-h/2 or x<hpoint+h/2 or y>vpoint-v/2 or y<vpoint+v/2)
			{
				hspeed=0;
				x=hpoint;
				vspeed=0;
				y=vpoint;
			}
			break;
		case 2:
			if(x!=hpoint)
			{
				x+=(hpoint-x)/h;
			}
			if(y!=vpoint)
			{
				y+=(vpoint-y)/v;
			}
			break;
		case 3:
			if(x>hp-h/2 or x<hp+h/2 or y>vp-v/2 or y<vp+v/2)
			{
				hspeed=0;
				x=hpoint;
				vspeed=0;
				y=vpoint;
			}
			break;
	}
	//Size
	switch(scm)
	{
		case 1:
			if(image_xscale>xsp-xspd/2 or image_xscale<xsp+xspd/2 or image_yscale>ysp-yspd/2 or image_yscale<ysp+yspd/2)
			{
				image_xscale+=xspd;
				image_yscale+=yspd;
			}
			break;
		case 2:
			if(image_xscale != xsp or image_yscale != ysp)
			{
				image_xscale+=(xsp-image_xscale)/xspd;
				image_yscale+=(ysp-image_yscale)/yspd;
			}
			break;
	}
}
