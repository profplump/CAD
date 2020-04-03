// Process control
FAST = 1;
DEBUG = 0;

// Circle smoothness =~ build smoothness
$fs = 0.1 * (FAST * 10);
$fa = 1;

// Main tube paramteters
stageA = -18;
stageRadius = 26.25;
stageOffsetX = 51.5;
stageOffsetY = 31.0;
stageOffsetZ = 10.5;
stageOffsetA = 86.5;
stageZFuzz = 1.0;
stageAZ = 4.0;

// Side tube parameters
sideHeight = 3.75;
sideLength = 57.0;
sideRadius = 11.0;
sideSpread = 14.5 - sideRadius;
// There is probably a way to calculate this, but guess-and-check is fine for now
sideOverlap = (1 - 0.170);

// Tertiary offsets
stage3OffsetX = 45;
stage3OffsetY = -45;

// Base parmaeters
baseEdge = 5;
baseHeight = 50;
baseX = 137 + baseEdge;
baseY = 131 + (baseEdge / 2);


module sideBox(stageOffset) {
	polyhedron(
		points = [
			[stageRadius * sideOverlap, -sideSpread, 0], //FBR 0
			[stageRadius * sideOverlap, (sideRadius * 2) + sideSpread, 0], //NBR 1
			[stageRadius * sideOverlap, -sideSpread, (baseHeight - stageOffset)], //FTR 2
			[stageRadius * sideOverlap, (sideRadius * 2) + sideSpread, (baseHeight - stageOffset) ], //NTR 3
			[sideLength - sideRadius, 0, sideHeight], //FBL 4
			[sideLength - sideRadius, sideRadius * 2, sideHeight], //NBL 5
			[sideLength - sideRadius, 0, (baseHeight - stageOffset)], //FTL 6
			[sideLength - sideRadius, sideRadius * 2, (baseHeight - stageOffset)] //NTL 7
		],
		faces=[
			[0,1,3,2], //L
			[7,5,4,6], //R
			[2,3,7,6], //T
			[4,5,1,0], //B
			[0,2,6,4], //F
			[3,1,5,7], //N
		]);
}

module stageInset(stageOffset) {
	translate([0, 0, stageOffset]) {
		cylinder(h=(baseHeight - stageOffset + stageZFuzz), r=stageRadius);
		translate([sideLength - sideRadius, 0, sideHeight]) {
			cylinder(h=(baseHeight - stageOffset) - sideHeight, r=sideRadius);
		}
		translate([0, -sideRadius, 0]) {
			sideBox(stageOffset);
		}
	}
}

module dualStage() {
	color("red")
	translate([stage3OffsetX, stage3OffsetY, 0]) {
		rotate([2 * stageAZ, 0, -stageA + 180]) {
			stageInset(stageOffsetZ * 2);
		}
	}
	
	color("green")
	rotate([stageAZ, 0, stageOffsetA]) {
		stageInset(stageOffsetZ);
	}
	
	color("blue")
    translate([stageOffsetX, stageOffsetY, 0]) {
		rotate([0, 0, stageA]) {
			stageInset(0);
		}
	}
}

// Main build
difference() {

	// Base
	cube([baseX, baseY, baseHeight]);

	// Dual-stage inset, aligned to base
	translate([stageRadius + baseEdge, 67 + (baseEdge / 2), baseEdge]) {
		rotate([0,0,90 - stageOffsetA])
		dualStage();
	}
	
	// Carve just a little off the edges to help the preview render cleanly
	if (DEBUG) {
		translate([0, 0, baseHeight - 0.01]) {
			color("purple")
			cube([baseX, baseY, 0.02]);
		}
		translate([0, 0, -0.01]) {
			color("purple")
			cube([baseX, baseY, 0.02]);
		}
		translate([-0.01, 0, 0]) {
			color("purple")
			cube([0.02, baseY, baseHeight]);
		}
		translate([baseX - 0.01, 0, 0]) {
			color("purple")
			cube([0.02, baseY, baseHeight]);
		}
	}

	// Carve out the base for print speed
	if (FAST) {
		translate([223 + baseEdge, 10 - baseEdge, 0]) {
			color("green")
			cylinder(r=120, h=baseHeight);
		}
		translate([baseX - 11 + baseEdge, baseY - 1 + baseEdge, 0]) {
			color("blue")
			cylinder(r=30, h=baseHeight);
		}
		translate([-(58 + baseEdge), baseY - 10, 0]) {
			color("red")
			cylinder(r=80, h=baseHeight);
		}
	}
}
