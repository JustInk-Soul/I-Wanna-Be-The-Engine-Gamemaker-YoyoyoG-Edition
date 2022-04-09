/// @description Play current room music and put into the correct layer

Theme_Get(); 
Music_Get(); // Find and play the proper music for the current room

layer = layer_get_id("World"); // Put into the correct layer