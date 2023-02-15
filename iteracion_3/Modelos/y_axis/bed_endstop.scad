$fn=20;

TOR_DIAM            = 3+0.8;
TOR_CAB_DIAM        = 6+0.8;

MOTOR_CENTRO_DIAM   = 32;

SWITCH_LARGO        = 12.8;
SWITCH_ANCHO        = 5.7;
SWITCH_ALTO         = 6;
SWITCH_PINS_TOPE    = 2;

BASE_AGUJEROS_TOR   = 31;
BASE_LARGO          = BASE_AGUJEROS_TOR+TOR_DIAM*2+3*2;
BASE_ANCHO          = 10;
BASE_ESPESOR        = 3;
BASE_ESPESOR_TOR    = 1.6;

module YAxisSoporteEndstop()
{
    difference() {
        union() {
            translate([0, 0, BASE_ESPESOR/2]) cube([BASE_LARGO, BASE_ANCHO, BASE_ESPESOR], center=true);
            translate([-BASE_LARGO/2, BASE_ANCHO/2, 0]) cube([SWITCH_LARGO+BASE_ESPESOR_TOR*2, BASE_ESPESOR_TOR+SWITCH_ALTO, BASE_ESPESOR+SWITCH_ANCHO-0.2]);
        }
        translate([0, -BASE_AGUJEROS_TOR/2, 0]) # cylinder(h=BASE_ESPESOR, d=MOTOR_CENTRO_DIAM, $fn=50);
        for(i=[-1, 1]) {
            translate([BASE_AGUJEROS_TOR/2*i, 0, 0]) {
                # hull() 
                    for(i=[-1, 1])
                        translate([TOR_DIAM/1.5*i, 0, 0]) cylinder(h=BASE_ESPESOR, d=TOR_DIAM);
                # hull() 
                    for(i=[-1, 1])
                        translate([TOR_DIAM/1.5*i, 0, BASE_ESPESOR_TOR]) cylinder(h=BASE_ESPESOR_TOR, d=TOR_CAB_DIAM);
            }
        }
        translate([-(BASE_LARGO/2-SWITCH_LARGO/2-BASE_ESPESOR/2), SWITCH_ALTO+BASE_ESPESOR_TOR, SWITCH_ANCHO/2+BASE_ESPESOR]) rotate([-90,0,0]) # union() {
            translate([0,0,SWITCH_ALTO/2]) cube([SWITCH_LARGO, SWITCH_ANCHO, SWITCH_ALTO], center=true);
            for(i=[-1,0,1])
                translate([5*i, 0, -BASE_ESPESOR/2]) cube([2.8, SWITCH_ANCHO, BASE_ESPESOR], center=true);
        }
    }
}

YAxisSoporteEndstop();