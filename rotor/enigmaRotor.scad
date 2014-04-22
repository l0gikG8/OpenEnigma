N = 26;		//number of notches around full dial
r = 60;		//radius of the dial
t = 4; 		//thickness of dial
d = 30;		//displacement above base plate
i = 100;		//number of iterations per notch


module notch() {
	step1 = 360 / (N * i);
	step2 = 360 / i;
	for (phi = [0 : i]) {
		linear_extrude(height = t, center = false) {
			assign (h = r + cos(phi * step2)) {
				polygon(points= [	[0,0],
										[h * cos(phi*step1), h * sin(phi*step1)],
										[h * cos((phi+1)*step1), h * sin((phi+1)*step1)] ],
							paths=[[0,1,2]]);
			}
		}
	}
}

module dial() {
	for (phi = [-3 : 2]) {
		rotate ([0,0,phi/N*360]) notch();
	}
}

rotate([ 0, -90, 0]) difference() {
	translate([-r*3/4,0,0]) dial();
	translate([-2*r-2,-r-1,-1]) cube(size=[2*r+2,2*r+2,t+2]);
}