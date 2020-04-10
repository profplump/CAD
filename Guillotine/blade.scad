razor_carrier_width = 39.7;
razor_carrier_depth = 1.0;
razor_carrier_height = 7.0;
razor_blade_width = 38.9;
razor_blade_depth = 0.3;
razor_blade_height = 19.6 - razor_carrier_height;
razor_notch_width = (razor_blade_width - 32.0) / 2;
razor_notch_radius = 2.9 / 2;
razor_notch_height = 8.5;

sled_razor_clearance = 0.2;
sled_razor_inset = 4.0;
sled_nib_width = (razor_notch_width * 1.0) - (0*sled_razor_clearance);
sled_nib_height = razor_notch_radius * 0.75;
sled_slot_width = razor_carrier_width + sled_razor_clearance;
sled_slot_height = razor_notch_height + (sled_nib_height / 2) + razor_notch_radius - sled_razor_inset;
sled_slot_depth = razor_carrier_depth + sled_razor_clearance;
sled_header_height = 5;
sled_header_width = sled_slot_height + 1;
sled_side_width = 2.5;
sled_height = sled_slot_height + sled_header_height;
sled_width = sled_slot_width + sled_side_width * 2;
sled_depth = razor_carrier_depth + 2;

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
				razor_notch_width - razor_notch_radius,
				-razor_blade_depth
			]) {
				translate([-razor_notch_radius, -razor_notch_width, 0]) {
					cube([razor_notch_radius * 2, razor_notch_width, razor_carrier_depth]);
				}
				cylinder(h = razor_carrier_depth,
					r1 = razor_notch_radius, r2 = razor_notch_radius);
			}
			translate([
				razor_notch_radius + (razor_notch_height - razor_carrier_height),
				razor_blade_width - razor_notch_width + razor_notch_radius,
				-razor_blade_depth
			]) {
				translate([-razor_notch_radius, 0, 0]) {
					cube([razor_notch_radius * 2, razor_notch_width, razor_carrier_depth]);
				}
				cylinder(h = razor_carrier_depth,
					r1 = razor_notch_radius, r2 = razor_notch_radius);
			}
		}
	}
}

module sled() {
	difference() {
		cube([sled_header_height, sled_width, sled_depth]);
		translate([
			sled_header_height - sled_razor_inset,
			sled_side_width, (sled_depth / 2) - (sled_slot_depth / 2)
		]) {
			cube([sled_razor_inset + clean_buffer, sled_slot_width, sled_slot_depth]);
		}
	}
	translate([sled_header_height, 0, 0]) {
		cube([sled_slot_height, sled_side_width, sled_depth]);
		translate([sled_slot_height - sled_nib_height, sled_side_width, 0]) {
			cube([sled_nib_height, sled_nib_width, sled_depth]);
		}
	}
	translate([sled_header_height, sled_slot_width + sled_side_width, 0]) {
		cube([sled_slot_height, sled_side_width, sled_depth]);
		translate([sled_slot_height - sled_nib_height, -sled_nib_width, 0]) {
			cube([sled_nib_height, sled_nib_width, sled_depth]);
		}
	}
}

module blade_on_sled() {
	color([0, 0.3, 0.7, 1]) {
		sled();
	}
	translate([
		sled_height - sled_slot_height - sled_razor_inset,
		(sled_width - razor_carrier_width) / 2,
		(sled_depth / 2) - (razor_carrier_depth / 2)
	]) {
		color([0.6, 0.3, 0, 1]) {
			blade();
		}
	}
}
