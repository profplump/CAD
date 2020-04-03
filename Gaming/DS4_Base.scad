$fa = 0.5;
$fs = 0.5;

inside_x = 124;
inside_y = 115;
offset_x = 5;
offset_y = -12;
offset_z = 4;
angle = 35;
outside_x = inside_x + (2 * offset_x);
outside_y = inside_y + (2 * offset_y);
outside_z = 130;
front = cos(angle) * (outside_x - offset_x) + offset_x;

cable_radius = 15;
cable_radius_small = 8;

screw_taper = 5;
screw_radius = 5;
screw_offset = 4;
screw_radius_small = 2.5;

module screwHole(x, y) {
	translate([x, y, 0]) {
		translate([0, 0, screw_offset + screw_taper]) {
			cylinder(h = outside_z + 1, r = screw_radius);
		}
		translate([0, 0, screw_offset]) {
			cylinder(h = screw_taper, r1 = screw_radius_small, r2 = screw_radius);
		}
		translate([0, 0, -1]) {
			cylinder(h = outside_z + 1, r = screw_radius_small);
		}
	}
}

difference() {
	// Primary Cube
    cube([outside_x, outside_y, outside_z]);
	
	// Gross angle cut
    rotate([0, angle, 0]) {
        translate([-outside_x, -outside_y, outside_z / 2]) {
            cube([(outside_x * 2) + 1, (outside_y * 2) + 1, (outside_z * 2) + 1]);
        }
    }

	// Main inset
    color([1,0,0]) {
        rotate([0, angle, 0]) {
            translate([-((tan(angle) * outside_z / 2) - offset_x), offset_y, (outside_z / 2) - offset_z]) {
                cube([inside_x, inside_y, offset_z + 1]);
            }
        }
    }

	// Flat front
	color([0,1,0]) {
		translate([front, -outside_y, -outside_z]) {
			cube([(outside_x * 2) + 1, (outside_y * 2) + 1, (outside_z * 2) + 1]);
		}
	}

	// Cable cut
	translate([-1, outside_y / 2, -1]) {
		rotate([0, 90, 0]) {
			cylinder(h = front / 2 + 1, r = cable_radius_small);
		}
		translate([front / 2, 0, 0]) {
			cylinder(h = outside_z + 1, r = cable_radius);
		}
	}
	
	// Screw insets
	translate([front / 4 * 3, screw_radius / 2, 0]) {
		screwHole(0, outside_y / 4 - screw_radius / 2);
		screwHole(0, outside_y / 4 * 3 - screw_radius / 2);
	}
	translate([front / 4, screw_radius / 2, 0]) {
		screwHole(0, outside_y / 4 - screw_radius / 2);
		screwHole(0, outside_y / 4 * 3 - screw_radius / 2);
	}
}