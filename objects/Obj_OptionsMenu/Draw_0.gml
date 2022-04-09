/// @description Draw menu

draw_set_color(c_black);
draw_set_font(fDefault30);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw menu option text
for (var i = 0; i < optionNum; i++) {
    draw_text(xSelector,ySelector+(ySeperation*i),strSelect[i]);
}

draw_set_halign(fa_right);

// Draw current option settings

if (global.muteMusic) {
    draw_text(xSelector+xSeperation,ySelector,"Off");
} else {
    draw_text(xSelector+xSeperation,ySelector,"On");
}

draw_text(xSelector+xSeperation,ySelector+ySeperation,string(global.volumeLevel)+"%");
    
if (global.fulleenMode) {
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*2),"Fulleen");
} else {
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*2),"Windowed");
}

if (global.smoothingMode) {
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*3),"On");
} else {
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*3),"Off");
}

// Draw menu sprite
draw_sprite(Spr_PlayerIdle,playerIndex,xSelector-16,ySelector+(ySeperation*optionSelect)+19);

Draw_ButtonInfo(false); // Draw menu button text