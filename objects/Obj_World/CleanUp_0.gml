/// @description Clean up dynamic resources

// Check if the game is currently paused
if (global.gamePaused) {
	// Delete pause een sprite
	sprite_delete(global.pauseSpr_);
				
	// Enable automatically drawing the application surface
	application_surface_draw_enable(true);
}