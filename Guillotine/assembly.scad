clean_buffer = 0.01;
$fs = 0.2;
//$t = 0.0;

include <blade.scad>;
include <frame.scad>;

color([0,0.5,0.4,1]) {
	frame();
}

translate([8 + ($t * 30), 4.5, frame_depth]) {
	rotate(-15) {
		blade_on_sled();
	}
}
