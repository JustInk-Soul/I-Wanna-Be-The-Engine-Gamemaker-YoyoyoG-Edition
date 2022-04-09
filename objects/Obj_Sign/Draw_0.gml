/// @description Draw self/sign text

draw_self();
draw_set_color(c_black);
draw_set_font(fDefault12);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
if (showText) {
    
    var yOffset = string_height(signText);
    draw_text(x+(sprite_width/2),y-yOffset,signText);
}
else
{
	var yOffset = string_height("Press [Up] Key");
    draw_text(x+(sprite_width/2),y-yOffset,"Press [Up] Key");
}
