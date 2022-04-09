/// @description Follow the player

if (instance_exists(Obj_Player)) {
    x += (Obj_Player.x - x) / snapDiv;
    y += (Obj_Player.y - y) / snapDiv;
}