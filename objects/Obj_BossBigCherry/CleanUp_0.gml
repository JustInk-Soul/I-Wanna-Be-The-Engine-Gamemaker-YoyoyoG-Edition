var item = instance_create_depth(x,y-64,0,Obj_BossItem);
item.sprite_index=Spr_BossItem_Cherry;
item.itemNum = 1;
var warp = instance_create_depth(x,y,0,Obj_Warp);
warp.roomTo = Room_End;
Music_Stop();
