header_width = 32.0;
header_height = 11.3;
footer_width = 33.6;
footer_height = 4.0;
riser_width = 3.5;
riser_height = 25.7;
neck_radius = 11.0 / 2;
stock_width = 23.0;
stock_height = 15.2;
stock_foot_height = 3.7;
frame_depth = 3.3;

clean_buffer = 0.01;

header_riser_offset = ((header_width - stock_width) / 2) - riser_width;

module frame() {
	cube([header_height, header_width, frame_depth]);
	translate([header_height, header_riser_offset, 0]) {
		cube([riser_height + stock_height + stock_foot_height, riser_width, frame_depth]);
		translate([0, stock_width + riser_width, 0]) {
			cube([riser_height + stock_height + stock_foot_height, riser_width, frame_depth]);
		}
	}
	translate([header_height + riser_height, header_riser_offset + riser_width, 0]) {
		difference() {
		cube([stock_height, stock_width, frame_depth]);
		translate([stock_height / 2, stock_width / 2, -clean_buffer]) {
			cylinder($fn = 36, h = frame_depth + (clean_buffer * 2),
				r1 = neck_radius, r2 = neck_radius);
		}
		}
	}
	translate([
		header_height + riser_height + stock_height + stock_foot_height,
		(header_width - footer_width) / 2,
		0
	]) {
		cube([footer_height, footer_width, frame_depth]);
	}
}