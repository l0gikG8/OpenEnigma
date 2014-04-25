use <../includes/dimlines.scad>		// from Don Smiley at http://www.cannymachines.com/entries/9/openscad_dimensioned_drawings
									// text generation from PGreenland at http://www.thingiverse.com/thing:59817  Creative Commons-Attribution-Share Alike

// associate index to axis
X = 0;
Y = 1;
Z = 2;

// measurements in inches
Wall_thickness = 0.125;
Size_of_PCB = [5.875, 7, 0.0625];
Size_of_Top_Plate = [6.875, 8, 0.0625];
Size_of_Internal_Box = [Size_of_Top_Plate[X] + Wall_thickness, Size_of_Top_Plate[Y] + Wall_thickness, 2.4375];

// convert to millimeters
t = Wall_thickness * 25.4;
PCB = Size_of_PCB * 25.4;
TPL = Size_of_Top_Plate * 25.4;
IB = Size_of_Internal_Box * 25.4;
USBplug = [ 11.5, 10.5 ];

module cutout(outerX, outerY, roundedCornerRadius, ledge) {
	$fn=100;
	translate( [ roundedCornerRadius + ledge/2, roundedCornerRadius + ledge/2, -t/2] ) minkowski() {
		cube([outerX-2*roundedCornerRadius-ledge, outerY-2*roundedCornerRadius-ledge, t]);
		cylinder( r=roundedCornerRadius, h=t );
	}
}

module backPlate() {
	cube([IB[X], t, IB[Z]]);
}

module sidePlate() {
	cube([t, IB[Y], IB[Z]]);
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
		translate([t/2,t/2,IB[Z]-TPL[Z]+0.01]) cube(TPL);    							//topPlate cutout
		cutout( outerX=IB[X], outerY=IB[Y], roundedCornerRadius=15, ledge=10);			//bottomPlate cutout
		translate( [0, IB[Y]/2, IB[Z]/2] ) rotate( [90, 0 , 90] )						//USB plug cutout
			cutout( outerX=USBplug[X], outerY=USBplug[Y], roundedCornerRadius=3, ledge=0);
	}
}

translate ([-IB[X]/2, -IB[Y]/2, 0]) internalBox();

//sample_dimensions();






