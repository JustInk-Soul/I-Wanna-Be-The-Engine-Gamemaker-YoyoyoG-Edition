// Check killer collision
if(killer)
{
	if (place_meeting(x,y,Obj_Player)) {	
		Player_Kill();
	}
}
