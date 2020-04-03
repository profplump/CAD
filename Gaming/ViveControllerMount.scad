// Smooth curves
$fs = 0.4;

// Measurements relative to the bottom center of the handle
bottom_width = 34;
bottom_depth = 22;
bottom_height = 16;
top_width = 39;
top_depth = 28;
top_height = 55;

// Calculated values based on those measurements
handle_rise = top_height - bottom_height;
handle_depth_slope = handle_rise / (top_depth - bottom_depth);
handle_width_slope = handle_rise / (top_width - bottom_width);
handle_depth_angle = atan(handle_depth_slope);
handle_width_angle = atan(handle_width_slope);

// Design parameters. These are mostly free.
side_height = top_height - bottom_height;
side_depth = bottom_depth;
side_width = 5;

front_height = side_height;
front_depth = side_width;
front_width = bottom_width;

// Center
//color([1,0,0]) { cube([10,10,10], center = true); }

// Left & Right
lr_x = (bottom_width / 2 ) + side_width;
lr_y = side_depth / 2;
translate([-lr_x, lr_y, 0]) {
	rotate([180, handle_width_angle - 180, 0]) {
		cube([side_height, side_depth, side_width]);
		}
}
translate([lr_x, -lr_y, 0]) {
	rotate([0, -handle_width_angle, 0]) {
		cube([side_height, side_depth, side_width]);
	}
}

// Front & Back
fb_x = front_width / 2;
fb_y = (bottom_depth / 2) + front_depth;
translate([fb_x, -fb_y, 0]) {
	rotate([handle_depth_angle - 180, 180, 0]) {
		cube([front_width, front_height, front_depth]);
	}
}
translate([-fb_x, fb_y, 0]) {
	rotate([handle_depth_angle, 0, 0]) {
		cube([front_width, front_height, front_depth]);
	}
}