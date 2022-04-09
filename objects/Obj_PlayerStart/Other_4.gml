/// @description Spawn the player

if (!instance_exists(Obj_Player)) {
	instance_create_layer(x+17,y+23,"Player",Obj_Player);
}