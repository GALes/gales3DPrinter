$fn=30;

ALTO            = 25;
DIAMETRO        = 23;
MOTOR_EJE_DIAM  = 4.5;
VARILLA_DIAM    = 8;

TORNILLO_DIAM   = 3.2;
TORNILLO_LARGO  = DIAMETRO;
TUERCA_DIAM     = 6.5;

module z_acople()
{
    difference() {
        union() {
            cylinder(d=DIAMETRO, h=ALTO);
        }
        # cylinder(d=MOTOR_EJE_DIAM, h=ALTO/2);
        translate([0, 0, ALTO/2]) # cylinder(d=VARILLA_DIAM, h=ALTO/2);
        translate([DIAMETRO/4-2, 0, ALTO/2]) # cube([DIAMETRO, 1, ALTO], center=true);
        translate([-DIAMETRO/4-2, 0, 0]) # cylinder(d=2, h=ALTO);
        for(i=[1,3]) {
            pos_tornillo_z = DIAMETRO/2-(DIAMETRO/2-VARILLA_DIAM/2)/2 - 0.5;
            translate([pos_tornillo_z, DIAMETRO/2, ALTO*i/4]) rotate([90, 0, 0]) 
                # cylinder(d=TORNILLO_DIAM, h=TORNILLO_LARGO);
            translate([pos_tornillo_z, DIAMETRO/2, ALTO*i/4]) rotate([90, 0, 0]) 
                # cylinder(d=TUERCA_DIAM, h=DIAMETRO/2-2, $fn=6);
            translate([pos_tornillo_z, 0-2, ALTO*i/4]) rotate([90, 0, 0]) 
                # cylinder(d=TUERCA_DIAM, h=DIAMETRO/2-2);
        }
    }
}

z_acople();