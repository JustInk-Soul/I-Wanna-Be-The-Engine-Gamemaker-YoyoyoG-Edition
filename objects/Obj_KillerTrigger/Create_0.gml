/// @description Initialize variables

event_inherited();

triggered = false;

// Set these in creation code
spr = -1; //Defual value
sprite_change = false;
trg = 0; //Sets which trigger to check
tri = 0;
trv = true;//Sets visible when triggered
trk = true;//Sets killer when triggered
spro = -1 ;//Fast set sprite orinig,-1 are not change  /// 0 1 2
sprox = 0;//Sprite xoffset                             /// 3 4 5
sproy = 0;//Sprite yoffset                             /// 6 7 8
mov = 0;//Sets move mode when triggered
scm = 0;//Sets scale mode when triggered

v = 0; // Sets vspeed when triggered
h = 0; // Sets hspeed when triggered
xs = 1;// Sets xscale when triggered
ys = 1;// Sets yscale when triggered
xsp = 1;// Sets xscale point when triggered
ysp = 1;// Sets yscale point when triggered

spd = 0; // Sets speed when triggered
dir = 0; // Sets direction when triggered
xspd = 1; // Sets xscale speed when triggered
yspd = 1; // Sets yscale speed when triggered
vp = 0; // Sets x point when triggered
hp = 0; // Sets y point when triggered


