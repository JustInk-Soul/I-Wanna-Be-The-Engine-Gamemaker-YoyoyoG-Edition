/// @description Check if triggered
if(!triggered) 
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
	else
	{
		hpoint=x+hp;
		vpoint=y+vp;
	}
}
else
{
	//Move
	switch(mov)
	{
		case 1:
			if(x>hpoint-h/2 or x<hpoint+h/2)
			{
				hspeed=0;
				x=hpoint;
			}
			if(y>vpoint-v/2 or y<vpoint+v/2)
			{
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
			if(x==hp)
			{
				hspeed=0;
			}
			if(y==vp)
			{
				vspeed=0;
			}
			break;
	}
	//Size
	switch(scm)
	{
		case 0:
			image_xscale+=(xsp-image_xscale)/xspd;
			image_yscale+=(ysp-image_yscale)/yspd;
			break;
	}
}
