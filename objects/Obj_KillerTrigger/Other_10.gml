/// @description Trigger Event

switch(mov)
{
	case 0:
	case 1:
		if((v != 0) or (h != 0)) 
		{
			vspeed = v;
			hspeed = h;
		}
		else if(spd != 0) 
		{
			speed = spd;
			direction = dir;
		}
		break;
}

if((xs != image_xscale) or (ys != image_yscale)) 
{
	image_xscale = xs;
	image_yscale = ys;
}

visible=trv;
killer=trk;


