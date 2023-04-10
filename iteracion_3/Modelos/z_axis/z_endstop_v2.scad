$fn=20;

TOR_DIAM            = 3+0.8;
TOR_CAB_DIAM        = 6+0.8;
TOR_DIST_TOP        = 16;

MOTOR_CENTRO_DIAM   = 32;

SWITCH_LARGO        = 12.8;
SWITCH_ANCHO        = 5.7;
SWITCH_ALTO         = 6;
SWITCH_PINS_TOPE    = 2;

BASE_AGUJEROS_TOR   = 20;
BASE_LARGO          = BASE_AGUJEROS_TOR+TOR_DIAM*2+3*2;
BASE_ANCHO          = TOR_DIST_TOP+TOR_DIAM/1.5*3;
BASE_ESPESOR        = 2.5;
BASE_ESPESOR_TOR    = 1.6;

module SwitchHolder()
{
    difference() {
        union() {
            translate([0, 0, (BASE_ESPESOR+SWITCH_ANCHO-0.2)/2]) cube([SWITCH_LARGO+BASE_ESPESOR_TOR*2, BASE_ESPESOR_TOR+SWITCH_ALTO, BASE_ESPESOR+SWITCH_ANCHO-0.2], center=true);
        }
        translate([0,-SWITCH_ANCHO/2+1,SWITCH_ALTO/2+BASE_ESPESOR]) rotate([-90,0,0]) # union() {
            translate([0,0,SWITCH_ALTO/2]) cube([SWITCH_LARGO, SWITCH_ANCHO, SWITCH_ALTO], center=true);
            for(i=[-1,0,1])
                translate([5*i, 0, -BASE_ESPESOR/2]) cube([2.8, SWITCH_ANCHO, BASE_ESPESOR], center=true);
        }
    }
}

// -(BASE_LARGO/2-SWITCH_LARGO/2-BASE_ESPESOR/2), SWITCH_ALTO+BASE_ESPESOR_TOR, SWITCH_ANCHO/2+BASE_ESPESOR


module YAxisSoporteEndstop()
{
    difference() {
        union() {
            translate([0, TOR_DIST_TOP-BASE_ANCHO/2-2.2, BASE_ESPESOR/2]) cube([BASE_LARGO, BASE_ANCHO, BASE_ESPESOR], center=true);
            translate([0, TOR_DIST_TOP-(SWITCH_ALTO+6)/2,0]) SwitchHolder();
        }
        for(i=[-1, 1]) {
            translate([BASE_AGUJEROS_TOR/2*i, 0, 0]) {
                # hull() 
                    for(i=[-1, 1])
                        translate([0, TOR_DIAM/1.5*i, 0]) cylinder(h=BASE_ESPESOR, d=TOR_DIAM);
                # hull() 
                    for(i=[-1, 1])
                        translate([0, TOR_DIAM/1.5*i, BASE_ESPESOR_TOR]) cylinder(h=BASE_ESPESOR_TOR, d=TOR_CAB_DIAM);
            }
        }
    }
}

YAxisSoporteEndstop();
//SwitchHolder();