include <blade.scad>;
include <frame.scad>;

color([0,0.5,0.4,1]) {
	frame();
}

color([0,0.5,0.7,1]) {
	translate([15, -4, frame_depth]) {
		blade();
	}
}
