$fs = 0.4;
/* Simple part to provide parametric shim to match increased thicknes of
   glass bed added to FlashForge Creator X, and PowerSpec re-branded 3dX
   NOTE: The development of this shim included learning openscad. This
   was built by accretion; no beautiful code here!

   1. We define a cylinder and clip it to make a retaining bracket,
   along with a square section extending to the back of the printer.
   This is offset to the 'left' in the x-axis.
   2. We define a crossbar to extend along the back of the plate.
   3. We define another retaining bracket, offset to the 'right' on the
   x-axis and flipped to point the other direction.
   4. These parts are unioned together to make the complete shim
*/

// Change this height parameter to accomodate different glass thickness
// I used 5.5mm for my 3.2mm glass, to give leeway for bed leveling
height = 7.0;

// thickness is a general sizing parameter, used to keep the brackets
// trim and elegant
thickness = 2;

// On my printer, the z-axis stabilizing rods are 20.9mm diameter
postdiameter = 20.9;

squaredimension = 15;

cutback = thickness * 2;

// cubesize is used to clip a cylinder that is used as the retaining
// 'ring' around the z-azis stabilizing rods
cubesize = postdiameter + thickness + 5;

// we need to reach the limit switch. This is parameterized for tinkering
distance2back = 18;

// The two z-axis stabilizing rods are 10cm apart
center2centerwidth = 100;

/* one side cylinder and square extension to back of plate */
	translate([-50,0,0]) {
	difference() {
		union() {

			cylinder(h=height, r=postdiameter/2 + thickness, center=true);
		
			translate([thickness * 2,0,-(height/2)])
			{
				cube ([postdiameter/2 - thickness,distance2back, height]);
			} // end of translate
		} // end of union

		cylinder(h=height+1, r=postdiameter/2, center=true);

		translate([-(cubesize-cutback),-cubesize/2,-(height *1.5)])
			{
			cube(cubesize,cubesize,height+5);
		} // end of translate
	} // end of difference
	} // end of translate

/* cross bar */
	translate([-(center2centerwidth/2 - thickness * 2),distance2back - squaredimension / 2,-(height / 2)]) {
		cube([center2centerwidth - (thickness * 4),squaredimension,height]);
	} // end of translate of cross-bar

/* cylinder and square extension, flipped for other side */
	translate([50,0,0]) {
	rotate([0,180,0]) {
	difference() {
		union() {

			cylinder(h=height, r=postdiameter/2 + thickness, center=true);
		
			translate([thickness * 2,0,-(height/2)])
			{
				cube ([postdiameter/2 - thickness,distance2back, height]);
			} // end of translate
		} // end of union

		cylinder(h=height+1, r=postdiameter/2, center=true);

		translate([-(cubesize-cutback),-cubesize/2,-(height *1.5)])
			{
			cube(cubesize,cubesize,height+5);
		} // end of translate
	} // end of difference
	} // end of rotate
	} // end of translate

// } end of union