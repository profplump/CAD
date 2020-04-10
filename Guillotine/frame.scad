frame_depth = 3.3;
stock_inset_height = 0.5;
stock_inset_depth = 1.0;

header_width = 42.0;
header_height = header_width * 0.2;
footer_width = header_width * 1.05;
footer_height = footer_width * 0.1;
riser_width = header_width * 0.1;
riser_height = header_height * 4.5;
stock_width = header_width * 0.67;
stock_height = stock_width * 0.67;
stock_foot_height = footer_height * 1.25;
neck_radius = stock_width / 5;

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
			cylinder(h = frame_depth + (clean_buffer * 2),
				r1 = neck_radius, r2 = neck_radius);
		}
		translate([stock_height / 2, 0, frame_depth - stock_inset_depth]) {
			cube([stock_inset_height, stock_width, stock_inset_depth + clean_buffer]);
		}
		translate([0, 0, frame_depth - stock_inset_depth]) {
			cube([stock_height, stock_inset_height, stock_inset_depth + clean_buffer]);
		}
		translate([0, stock_width - stock_inset_height, frame_depth - stock_inset_depth]) {
			cube([stock_height, stock_inset_height, stock_inset_depth + clean_buffer]);
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