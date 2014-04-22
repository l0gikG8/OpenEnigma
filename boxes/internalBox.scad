// associate index to axis
X = 0;
Y = 1;
Z = 2;

// measurements in inches
Size_of_PCB = [5.875, 7, 0.0625];
Size_of_Top_Plate = [6.875, 8, 0.125];
Size_of_Internal_Box = [Size_of_Top_Plate[X], Size_of_Top_Plate[Y], 2.4375];
Wall_thickness = 0.25;
space_between_parts = 2;

// convert to metric
PCB = Size_of_PCB * 2.54;
TPL = Size_of_Top_Plate * 2.54;
IB = Size_of_Internal_Box * 2.54;
t = Wall_thickness * 2.54;

module backPlate() {
	cube([IB[X]+t, t, IB[Z]]);
}

module sidePlate() {
	cube([t, IB[Y]+t, IB[Z]]);
}

module bottomPlate() {
	$fn=100;
	difference() {
		cube([IB[X]+t, IB[Y]+t, t]);
		translate([IB[X]/4, IB[Y]/4, -t/2]) minkowski() {
			cube([IB[X]/2, IB[Y]/2, t]);
			cylinder(r=2,h=t);
		}
	}
}

module internalBox() {
	difference() {
		union() {
			backPlate();
			sidePlate();
			translate([IB[X]+t, 0, 0]) mirror([1, 0, 0]) sidePlate();
			bottomPlate();
		}
		translate([t/2,t/2,IB[Z]-TPL[Z]]) cube(TPL);
	}
}

translate (-[IB[X]/2, IB[Y]/2, 0]) internalBox();









