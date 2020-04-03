$fa = 0.5;
$fs = 0.5;

outside_r = 42/2;
inside_r = 32/2;
outside_z = 104.2/2;

difference(){ 
	
	union(){
		cylinder(h=outside_z, r1= outside_r, r2= outside_r -1);
		rotate([180,0,0]) cylinder(h=outside_z, r1= outside_r, r2= outside_r -1);
	}
	
	translate([0,0,-.5]){
		cylinder(h=outside_z+1, r = inside_r, $fn=100);
	}
	rotate([180,0,0]) translate([0,0,-.5]){
		cylinder(h=outside_z+1, r = inside_r, $fn=100);
	}

}

