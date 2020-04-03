razor_carrier_width = 39.5;
razor_carrier_depth = 1.0;
razor_carrier_height = 7.0;
razor_blade_width = 38.8;
razor_blade_depth = 0.3;
razor_blade_height = 19.6 - razor_carrier_height;
razor_notch_width = 32.0;
razor_notch_radius = 2.9 / 2;
razor_notch_height = 8.5;

module blade() {
	cube([razor_carrier_height, razor_carrier_width, razor_carrier_depth]);
	translate([
		razor_carrier_height,
		(razor_carrier_width - razor_blade_width) / 2,
		razor_carrier_depth / 2 - razor_blade_depth / 2
	]) {
		difference() {
			cube([razor_blade_height, razor_blade_width, razor_blade_depth]);
			translate([
				razor_notch_radius + (razor_notch_height - razor_carrier_height),
				razor_notch_radius / 2,
				-(razor_blade_depth)
			]) {
					cylinder($fn = 36, h = razor_carrier_depth,
						r1 = razor_notch_radius, r2 = razor_notch_radius);
						translate([0, razor_blade_width - razor_notch_radius, 0]) {
							cylinder($fn = 36, h = razor_carrier_depth,
								r1 = razor_notch_radius, r2 = razor_notch_radius);
						}
			}
		}
	}
}

color([0,0.5,0.7,1]) {
	blade();
}
