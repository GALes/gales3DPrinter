
include <extrusor_pmi2.scad>;

$fn = 30;

PARED_ANCHO = 2;
PARED_ALTO = 3;

ANCHO = 62;
ALTO = 54;
BASE_POS_Z = ALTO-2.5;

TOR_DIS_DIAM = 4;
TOR_MOTOR_DIAM = 3;


module Soporte(cube1, cube2, posc2)
{
    hull() {
        cube(cube1);
        translate(posc2) cube(cube2);
    }
}

Disp_sop_alto = 20;
Disp_sop_ancho = 30;
module SoporteDisipador(pos_x = 0, pos_y = 0)
{
    Disp_sop_alto = 20;
    Disp_sop_ancho = 30;
    dist_tor = 18-TOR_DIS_DIAM;
    translate([pos_x-Disp_sop_alto/2, pos_y-Disp_sop_ancho/2]) {
        difference(){ union() {
                cube([Disp_sop_alto, Disp_sop_ancho, 6]);
            }
            translate([Disp_sop_alto/2-14/2, Disp_sop_ancho/2-26/2, 0]) #cube([14, 26, 3]);
            translate([10, Disp_sop_ancho/2-dist_tor/2, 3.5]) cylinder(r = TOR_DIS_DIAM/2+.5, 6);
            translate([10, Disp_sop_ancho/2+dist_tor/2, 3.5]) cylinder(r = TOR_DIS_DIAM/2+.5, 6);
        }
    }
}


// Pos: x = 30mm desde los tornillos del disipador, y = centro + diam_filamento / 2
module SoporteMotor(pos_x = 0, pos_y = 0)
{
    translate([BASE_POS_Z-13-30, ANCHO/2, 6+5]) rotate([0, 90, 180]) ExBloqueBaseInf();
}

module SoporteExtruder()
{
    difference(){ union() {
            cube([2, ANCHO, 1]);
            Soporte([5, .001, PARED_ANCHO], [5, 1, PARED_ANCHO], [ALTO-5, ANCHO-1, 0]);
            translate([0,ANCHO,PARED_ANCHO]) rotate([180,0,0]) Soporte([5, .001, PARED_ANCHO], [5, 1, PARED_ANCHO], [ALTO-5, ANCHO-1, 0]);
            translate([1, 0, 0]) Soporte([3, ANCHO, .001], [1, ANCHO, .001], [0 ,0, 3]);
            translate([1, 0, 0]) cube([ALTO-1-2.5, PARED_ANCHO, 2.5]);
            translate([1, ANCHO-PARED_ANCHO, 0]) cube([ALTO-1-2.5, PARED_ANCHO, 2.5]);
            translate([ALTO/2-1/2, 0, 0]) cube([2, ANCHO, 2.5]);
            translate([BASE_POS_Z-3, 0, 0]) cube([3, ANCHO, 2.5]);
            //Agarre disipador
            SoporteDisipador(BASE_POS_Z-13,ANCHO/2);
            //Agarre Motor
            SoporteMotor();
            //Soportes Motor
            translate([1,5,0]) cube([8,2,3]);
            translate([1,5,3]) Soporte([8, 2, .0001], [11, 2, 0.001], [-3.5-4,0,3.5]);
            translate([1,ANCHO/2-Disp_sop_ancho/2,0]) cube([ALTO-13, 2, 3]);
            translate([1,ANCHO/2-Disp_sop_ancho/2,3]) 
                Soporte([ALTO-13, 2, .001], [11, 2, 3], [-3.5-4, 0, 3.5]);
            translate([1,ANCHO/2+4/2-2.5,0]) cube([ALTO-13, 2, 3]);
            translate([1,ANCHO/2+4/2-2.5,3]) 
                Soporte([ALTO-13, 2, .001], [11, 2, 2], [-3.5-4, 0, 3.5]);
            translate([1,ANCHO/2+Disp_sop_ancho/2-2,0]) cube([ALTO-13, 2, 3]);
            translate([1,ANCHO/2+Disp_sop_ancho/2-2,3]) 
                Soporte([ALTO-13, 2, .001], [11, 2, 3], [-3.5, 0, 3.5]);
            // Topes inferiores
            translate([ALTO-2.5-5, 0, 0]) cube([5, 5, 5]);
            translate([ALTO-2.5-5, ANCHO-5, 0]) cube([5, 5, 5]);
            
        } // Menos
        // Trava superior e inferior
        translate([0, 0, 1]) cube([1, ANCHO, 1]);
        translate([BASE_POS_Z, 0, 1]) cube([2.5, ANCHO, 1]);
        // Agarre disipador
        translate([BASE_POS_Z-13-14/2,ANCHO/2-26/2,0]) #cube([14, 26, 3]);
    }
}

module CarroX()
{
    ancho1  = 64;
    alto1   = 44;
    ancho2  = 28;
    alto2   = 64;
    espesor = 3;
    
    rueda_tuer_diam   = 8.5+3;
    rueda_tuer_alto   = 5.5+1;
    rueda_tuer_x_dist = 7;
    rueda_tuer_y_dist = 10;
    
    difference() {
        union() {
            // base
            translate([0,0,espesor/2]) cube([ancho1, alto1, espesor], center=true);
            hull() {
                translate([0, 0, espesor/2]) cube([ancho2, alto1, espesor], center=true);
                translate([0, alto1/2-50, 0]) cylinder(d=ancho2, h=espesor);
            }
            // tuercas ruedas superiores
            for(i=[-1, 1]) {
                translate([ancho1/2*i-rueda_tuer_x_dist*i, alto1/2-rueda_tuer_y_dist, espesor]) 
                    cylinder(d=rueda_tuer_diam, h=rueda_tuer_alto, $fn=6);
            }
            translate([0, alto1/2-50, 0]) 
                    cylinder(d=rueda_tuer_diam, h=rueda_tuer_alto, $fn=6);
            // 
        }
    }
}

CarroX();

//SoporteExtruder();
//SoporteDisipador();
//SoporteMotor();
//Extruder();