include <../includes/dimlines.scad>		// from Don Smiley at http://www.cannymachines.com/entries/9/openscad_dimensioned_drawings
									// text generation from PGreenland at http://www.thingiverse.com/thing:59817  Creative Commons-Attribution-Share Alike

// associate index to axis
X = 0;
Y = 1;
Z = 2;

// measurements in inches
Size_of_PCB = [5+7/8, 7, 1/16];
Size_of_Top_Plate = [6+7/8, 8, 1/16];
Height_of_Internal_Box = 2+7/16;

scaleFactor = 1;			// use 25.4 to convert inches to millimeters
PCB = Size_of_PCB * scaleFactor;
TPL = Size_of_Top_Plate * scaleFactor;
h = Height_of_Internal_Box * scaleFactor;

separation = .75 * scaleFactor;

module backPlate() {
	cube([ TPL[X], (TPL[Y]-PCB[Y])/2, h ]);
}

module sidePlate() {
	cube([(TPL[X]-PCB[X])/2, TPL[Y], h ]);
	cube([(TPL[X]-PCB[X])/2, TPL[Y], h ]);
}

module internalBox() {
	union() {
		backPlate();
		sidePlate();
		translate([TPL[X], 0, 0]) mirror([1, 0, 0]) sidePlate();
	}
}

translate ([-TPL[X]/2, -TPL[Y]/2, 0]) internalBox();
#translate ([-PCB[X]/2, PCB[Y]/2, 0]) cube([PCB[X],(TPL[Y]-PCB[Y])/2, TPL[Z]]);

translate ([PCB[X]/2, PCB[Y]/2-separation, -.05]) rotate ([0,0,180]) dimensions(length=PCB[X], line_width=DIM_LINE_WIDTH, loc=0);
translate ([-PCB[X]/2+separation, -PCB[Y]/2, -.05]) rotate ([0,0,90]) dimensions(length=PCB[Y], line_width=DIM_LINE_WIDTH, loc=0);

translate ([TPL[X]/2, TPL[Y]/2+separation, -.05]) rotate ([0,0,180]) dimensions(length=TPL[X], line_width=DIM_LINE_WIDTH, loc=0);
translate ([TPL[X]/2+separation, -TPL[Y]/2, -.05]) rotate ([0,0,90]) dimensions(length=TPL[Y], line_width=DIM_LINE_WIDTH, loc=0);





