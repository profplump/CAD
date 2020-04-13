clean_buffer = 0.01;
$fs = 0.2;
//$t = 0.3;

include <blade.scad>;
include <frame.scad>;

color([0,0.5,0.4,1]) {
	frame();
}

translate([6 + ($t * 30), 11.8, frame_depth]) {
	rotate(-30) {
		blade_on_sled();
	}
}
