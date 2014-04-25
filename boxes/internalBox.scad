use <../includes/dimlines.scad>		// from Don Smiley at http://www.cannymachines.com/entries/9/openscad_dimensioned_drawings
									// text generation from PGreenland at http://www.thingiverse.com/thing:59817  Creative Commons-Attribution-Share Alike

// associate index to axis
X = 0;
Y = 1;
Z = 2;

// measurements in inches
Wall_thickness = 0.125;
slope = 7;
Size_of_Top_Plate = [6.875, 8, 0.0625];
Size_of_Plug_Board = [6.875, 2.4375, 0.0625];
Size_of_Internal_Box = [Size_of_Top_Plate[X] + Wall_thickness, Size_of_Top_Plate[Y]*cos(slope) + Wall_thickness/2 + Size_of_Top_Plate[Z]*sin(slope) + Wall_thickness, Size_of_Plug_Board[Y]+ Wall_thickness/2];

// convert to millimeters
t = Wall_thickness * 25.4;
TPL = Size_of_Top_Plate * 25.4;
IB = Size_of_Internal_Box * 25.4;
PB = Size_of_Plug_Board * 25.4;
USBplug = [ 11.5, 10.5 ];

module roundCorners(outerX, outerY, roundedCornerRadius, ledge) {
	$fn=100;
	translate( [ roundedCornerRadius + ledge/2, roundedCornerRadius + ledge/2, 0] ) minkowski() {
		cube([outerX-2*roundedCornerRadius-ledge, outerY-2*roundedCornerRadius-ledge, t]);
		cylinder( r=roundedCornerRadius, h=0.2 );
	}
}

module backPlate() {
	cube([ IB[X], t, IB[Z]+IB[Y]*tan(slope) ]);
}

module sidePlate() {
	difference() {
		cube([t, IB[Y], IB[Z]+IB[Y]*tan(slope) ]);
		translate([ -t/2, t, IB[Z]+IB[Y]*tan(slope) ]) rotate([ -slope, 0, 0 ]) cube([ 2*t, IB[Y]/cos(slope), IB[Y]*sin(slope) ]);
	}
}

module bottomPlate() {
	cube([IB[X], IB[Y], t]);
}

module internalBox() {
	difference() {
		union() {
			backPlate();
			sidePlate();
			translate([IB[X], 0, 0]) mirror([1, 0, 0]) sidePlate();
			bottomPlate();
		}
		translate([ t/2, t, IB[Z]-TPL[Z]/cos(slope)+IB[Y]*tan(slope)+0.1 ]) rotate([-slope, 0, 0]) cube(TPL);				//topPlate cutout
		translate([ t/2, IB[Y]+0.1, t/2 ]) rotate([90, 0, 0]) cube([PB[X],PB[Y]+ 2,PB[Z]]);									//plugBoard cutout
		translate([ t, t, -0.1 ]) roundCorners( outerX=IB[X]-2*t, outerY=IB[Y]-2*t, roundedCornerRadius=15, ledge=5);		//bottomPlate cutout
		translate( [-t/2, IB[Y]/2, IB[Z]/2] ) rotate( [90, 45 , 90] )														//USB plug cutout
			cube( [sqrt(2)/2*USBplug[X], sqrt(2)/2*USBplug[X], 2*t ]);
	}
}

translate ([-IB[X]/2, -IB[Y]/2, 0]) internalBox();
//sample_dimensions();





