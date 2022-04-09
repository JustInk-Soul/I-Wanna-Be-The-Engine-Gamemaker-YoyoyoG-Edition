if(boss_inv>0)
{
	boss_inv--;
	if((boss_inv mod 2)==0)
	{
		visible=false;
	}
	else
	{
		visible=true;
	}
}
else
{
	visible=true;
}

if(boss_hp <=0)
{
	instance_destroy();
}
if(!boss_start)
{
	if(instance_exists(Obj_Player))
	{
		Music_Stop();
		Obj_Player.frozen=true;
		alarm[0]=60;
		boss_start = true;
	}
}
