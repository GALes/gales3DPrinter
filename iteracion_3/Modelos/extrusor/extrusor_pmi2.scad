
$fn = 30;

PARED_ANCHO = 2;
PARED_ALTO = 3;

ANCHO = 62;
ALTO = 54;
BASE_POS_Z = ALTO-2.5;

TOR_DIS_DIAM = 4;
TOR_MOTOR_DIAM = 3;

// Variables globales extrusor
    motor_ancho = 42;
    motor_alto = motor_ancho;
    motor_diam_front = 25;
    ancho = motor_ancho;
    alto = motor_alto;
    espesor = 13;
    dist_tor = 34-TOR_MOTOR_DIAM;
    engran_diam = 8.4;
    ruleman_diam = 16;
    ruleman_alto = 5;
    filam_diam = 1.75;

module Soporte(cube1, cube2, posc2)
{
    hull() {
        cube(cube1);
        translate(posc2) cube(cube2);
    }
}

module Motor(tor_alt = 10, cyl_front_alt = 2, cyl_engr_alt = 13)
{
    cube([motor_alto, motor_ancho, 30]); //cuerpo
    translate([motor_alto/2, motor_ancho/2,-cyl_front_alt]) 
        cylinder(r = motor_diam_front/2, h = cyl_front_alt); //frente
    translate([motor_alto/2, motor_ancho/2,-cyl_engr_alt]) 
        cylinder(r = engran_diam/2, h = cyl_engr_alt); //engranaje
    for(i = [-1, 1], j = [-1, 1]) 
            translate([alto/2+dist_tor/2*i, ancho/2+dist_tor/2*j, -tor_alt]) 
                cylinder(r = TOR_MOTOR_DIAM/2+.5, h = tor_alt);
}

module ExBloqueBaseInf(pos_x = 0, pos_y = 0, pos_filam = 8.5)
{
    translate([pos_x-pos_filam, pos_y-(motor_ancho/2-engran_diam/2-filam_diam/2),0]) {
        difference(){ union() {
                
                cube([espesor, motor_ancho, 11]);
                translate([0, motor_ancho/2-7, 11]) 
                    Soporte([espesor, motor_ancho/2+7, 0.0001], [6, motor_ancho/2+7, 4], [espesor-6, 0, 0]);
                /*translate([0, motor_ancho/2, 10])   
                    cube([espesor, motor_ancho/2+12, motor_alto-10-25]);*/
            }
            translate([0, 0, 0]) rotate([0, -90, 0])
                #Motor(espesor-.5, 3/*espesor*/);
           /* translate([espesor/2, motor_ancho+12/2, 0]) 
                #cylinder(r = 4.5/2, h = motor_alto/2);*/
            translate([pos_filam, motor_ancho/2-engran_diam/2-filam_diam/2]) 
                #cylinder(r = filam_diam/2, h = motor_alto*2);
        }  
    }
   
}

module ExBloqueMovilSup(pos_x = 0, pos_y = 0, pos_filam = 8.5)
{
    translate([pos_x-pos_filam, pos_y-(motor_ancho/2-engran_diam/2-filam_diam/2),0]) {
        difference(){ union() {
                translate([0, 0, motor_alto-8]) rotate([35, 0, 0]) cube([espesor, motor_ancho+12, 8]);
                translate([0, (ruleman_diam-4)/2, motor_alto/2]) hull(){
                    rotate([0, 90, 0]) cylinder(r = ruleman_diam/2-2, h = espesor, center = false);
                       //1, ruleman_diam-2, espesor]);
                    translate([0, -(ruleman_diam-4)/2, motor_alto/2-1]) 
                        cube([espesor, ruleman_diam-4, 1]);
                }
                translate([espesor/2, 0, motor_alto-8-8]) 
                    rotate([35, 0, 0])
                        translate([0, ancho/2+dist_tor/2, 0])
                            cylinder(r = 4/2, h = 8);
                translate([5, ancho/2-dist_tor/2, motor_alto-8-10]) rotate([35, 0, 0]) cube([espesor-5, 16, 19.3]);
            
            }
            translate() rotate([0, -90, 0])
                #Motor(espesor, 3, 13);
            translate() cube([3, ruleman_diam-4, motor_alto*3/4]);
            translate([3,(ruleman_diam-4)/2,motor_alto/2]) rotate([0, 90, 0]) 
                #cylinder(r = 7.5/2, h = 1.5, $fn = 6);
            translate([3,(ruleman_diam-4)/2,motor_alto/2]) rotate([0, 90, 0]) 
                #cylinder(r = 5/2, h = espesor);
            translate([espesor-7,(ruleman_diam-4)/2,motor_alto/2]) rotate([0, 90, 0]) 
                #cylinder(r = (ruleman_diam+4)/2, h = 5);
            hull() {
                translate([pos_filam, motor_ancho/2-engran_diam/2-filam_diam*3/2, motor_alto/2]) 
                    #cylinder(r = filam_diam/2, h = motor_alto);
                translate([pos_filam, motor_ancho/2-engran_diam/2+filam_diam/2, motor_alto/2]) 
                    #cylinder(r = filam_diam/2, h = motor_alto);
            }
        }
    }
}

module ExBloqueResSup(pos_x = 0, pos_y = 0, pos_filam = 8.5)
{
    translate([pos_x-pos_filam, pos_y-(motor_ancho/2-engran_diam/2-filam_diam/2),0]) {
        difference(){ union() {
                translate([0, motor_ancho-12, motor_alto-10]){
                    difference() {
                        cube([espesor, 12, 10]);
                        translate([0, 0, 4]) rotate([35, 0, 0]) cube([espesor, 16, 10]);
                    }
                    
                }
                // , ancho/2+dist_tor/2*j
                 translate([espesor/2, ancho/2+dist_tor/2, alto/2+dist_tor/2]) 
                    rotate([32, 0, 0]) cylinder(r = 4/2, h = 10);
                
            }
            translate([0, 0, 0]) rotate([0, -90, 0])
                #Motor(espesor, espesor);
        }  
    }
}

// diam engranaje empuje: 8,8 mm
module Extruder()
{
    ExBloqueBaseInf();
   // rotate([180-35, 0, 0])
    //    ExBloqueMovilSup();
   // ExBloqueResSup();
}

//Extruder();