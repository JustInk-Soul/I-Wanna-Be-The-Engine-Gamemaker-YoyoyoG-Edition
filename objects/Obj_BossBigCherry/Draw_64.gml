if(boss_hp>0)
{
	draw_set_color(c_red);
	draw_rectangle(0,0,800,24,false);
	draw_set_color(c_green);
	draw_rectangle(0,0,(800/100)*boss_hp,24,false);
}
