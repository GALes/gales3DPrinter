SOP_AGUJ_DIST_ANCHO     = 55;
SOP_AGUJ_DIST_LARGO     = 107;
SOP_AGUJ_DIST_ESPESOR   = 3; //7.5-6;
SOP_AGUJ_DIAM           = 3+1.5;
SOP_AGUJ_DIST_SEP_ESP   = 7.5-6;

LCD_AGUJ_DIST_ANCHO     = 41;
LCD_AGUJ_DIST_LARGO     = 93;
LCD_PANT_ANCHO          = 41;
LCD_PANT_LARGO          = 71.5;

BTN_AGUJ_ANCHO          = 14;
BTN_AGUJ_LARGO          = 30;

ENC_AGUJ_ANCHO          = 19;
ENC_AGUJ_LARGO          = 30;

LCD_BOARD_ANCHO         = 47+1.5;
LCD_BOARD_LARGO         = 107+1.5;

/*
module lcdBoard(espesor = 5)
{
    difference() { union() {
        cube([LCD_BOARD_ANCHO, LCD_BOARD_LARGO, espesor]);
        }
        translate([LCD_BOARD_ANCHO, LCD_BOARD_LARGO, 0])
        # hull() {
            translate([-0.001, -5.5, 0]) cube([0.001, 5.5, espesor]);
            translate([-6, -1, 0]) cube([6, 1, espesor]);
        }
    }
    
}*/

module lcdBoard(espesor = 5)
{
    difference() { union() {
        cube([LCD_BOARD_ANCHO, LCD_BOARD_LARGO, espesor]);
        }
        translate([LCD_BOARD_ANCHO, 0, 0])
        # hull() {
            translate([0, 0, 0]) cube([0.001, 5.5, espesor]);
            translate([-6, 0, 0]) cube([6, 1, espesor]);
        }
    }
    
}

module soporte_old()
{
    difference() {
        union() {
            translate([0, 0, SOP_AGUJ_DIST_ESPESOR/2]) cube([SOP_AGUJ_DIST_ANCHO+SOP_AGUJ_DIAM+2*2, SOP_AGUJ_DIST_LARGO+SOP_AGUJ_DIAM+2*2, SOP_AGUJ_DIST_ESPESOR], center = true);
        }
        for (i=[[1, 1], [1, -1], [-1, 1], [-1, -1]]) {
            translate([SOP_AGUJ_DIST_ANCHO/2*i[0], SOP_AGUJ_DIST_LARGO/2*i[1]], 0) # cylinder(d=SOP_AGUJ_DIAM, h=SOP_AGUJ_DIST_ESPESOR, $fn=10);
        }
        // LCD
        translate([
            -LCD_PANT_ANCHO/2+SOP_AGUJ_DIST_ANCHO/2-2.2, 
            -LCD_PANT_LARGO/2+SOP_AGUJ_DIST_LARGO/2-19, 
            SOP_AGUJ_DIST_ESPESOR/2
        ]) # cube([LCD_PANT_ANCHO, LCD_PANT_LARGO, SOP_AGUJ_DIST_ESPESOR], center = true);
        // Boton
        translate([
            -BTN_AGUJ_ANCHO/2+SOP_AGUJ_DIST_ANCHO/2-4, 
            -BTN_AGUJ_LARGO/2+SOP_AGUJ_DIST_LARGO/2-0, 
            SOP_AGUJ_DIST_ESPESOR/2
        ]) # cube([BTN_AGUJ_ANCHO, BTN_AGUJ_LARGO, SOP_AGUJ_DIST_ESPESOR], center = true);
        // Encoder
        translate([
            -ENC_AGUJ_ANCHO/2-BTN_AGUJ_ANCHO+SOP_AGUJ_DIST_ANCHO/2-4, 
            -BTN_AGUJ_LARGO/2+SOP_AGUJ_DIST_LARGO/2-0, 
            SOP_AGUJ_DIST_ESPESOR/2
        ]) # cube([ENC_AGUJ_ANCHO, ENC_AGUJ_LARGO, SOP_AGUJ_DIST_ESPESOR], center = true);
        // Agujeros pantalla
        # translate([
            -LCD_AGUJ_DIST_ANCHO+SOP_AGUJ_DIST_ANCHO/2-1.2,
            SOP_AGUJ_DIST_LARGO/2-2.2,
            0
        ]) cylinder(d=SOP_AGUJ_DIAM, h=SOP_AGUJ_DIST_ESPESOR+5, $fn=10);
        # translate([
            -LCD_AGUJ_DIST_ANCHO+SOP_AGUJ_DIST_ANCHO/2-1.2,
            -LCD_AGUJ_DIST_LARGO+SOP_AGUJ_DIST_LARGO/2-2.2,
            0
        ]) cylinder(d=SOP_AGUJ_DIAM, h=SOP_AGUJ_DIST_ESPESOR, $fn=10);
        # translate([
            SOP_AGUJ_DIST_ANCHO/2-1.2,
            -LCD_AGUJ_DIST_LARGO+SOP_AGUJ_DIST_LARGO/2-2.2,
            0
        ]) cylinder(d=SOP_AGUJ_DIAM, h=SOP_AGUJ_DIST_ESPESOR, $fn=10);
        // Placa LCD
        translate([
            -LCD_BOARD_ANCHO+SOP_AGUJ_DIST_ANCHO/2+2.5,
            -LCD_BOARD_LARGO+SOP_AGUJ_DIST_LARGO/2+2,
            0
        ])
            lcdBoard(SOP_AGUJ_DIST_ESPESOR-SOP_AGUJ_DIST_SEP_ESP);
    }
}

module soporte()
{
    difference() { union() {
            difference() {
                union() {
                    translate([0, 0, SOP_AGUJ_DIST_ESPESOR/2]) 
                        cube([SOP_AGUJ_DIST_ANCHO+SOP_AGUJ_DIAM+2*2, SOP_AGUJ_DIST_LARGO+SOP_AGUJ_DIAM+2*2, SOP_AGUJ_DIST_ESPESOR], center = true);
                }
                // agujeros lados
                for (i=[[1, 1], [1, -1], [-1, 1], [-1, -1]]) {
                    translate([SOP_AGUJ_DIST_ANCHO/2*i[0], SOP_AGUJ_DIST_LARGO/2*i[1]], 0) # cylinder(d=SOP_AGUJ_DIAM, h=SOP_AGUJ_DIST_ESPESOR, $fn=10);
                }
                translate([0, 0, SOP_AGUJ_DIST_ESPESOR/2]) 
                       # cube([(SOP_AGUJ_DIST_ANCHO+SOP_AGUJ_DIAM+2*2)*6/8, (SOP_AGUJ_DIST_LARGO+SOP_AGUJ_DIAM+2*2)*7/8, SOP_AGUJ_DIST_ESPESOR], center = true);
            }
            translate([0, -SOP_AGUJ_DIST_LARGO/4, SOP_AGUJ_DIST_ESPESOR/2]) 
                cube([SOP_AGUJ_DIST_ANCHO+SOP_AGUJ_DIAM+2*2, 22.5, SOP_AGUJ_DIST_ESPESOR], center = true);
            
            translate([0, -SOP_AGUJ_DIST_LARGO/3+10, -9/2+SOP_AGUJ_DIST_ESPESOR]) 
                cube([SOP_AGUJ_DIST_ANCHO+SOP_AGUJ_DIAM+2*2, 4, 9], center = true);
            
            translate([0, 0, -SOP_AGUJ_DIST_ESPESOR/2]) 
                cube([4, SOP_AGUJ_DIST_LARGO+SOP_AGUJ_DIAM+2*2, SOP_AGUJ_DIST_ESPESOR], center = true);
        }
        // Agujeros pantalla
        # translate([
            SOP_AGUJ_DIST_ANCHO/2-4,
            -SOP_AGUJ_DIST_LARGO/2+34,
            0
        ]) cylinder(d=SOP_AGUJ_DIAM, h=SOP_AGUJ_DIST_ESPESOR, $fn=10);
        # translate([
            SOP_AGUJ_DIST_ANCHO/2-4-LCD_AGUJ_DIST_ANCHO,
            -SOP_AGUJ_DIST_LARGO/2+34,
            0
        ]) cylinder(d=SOP_AGUJ_DIAM, h=SOP_AGUJ_DIST_ESPESOR, $fn=10);
    }
    // bloque soporte lcd
    translate([
        (SOP_AGUJ_DIST_ANCHO+SOP_AGUJ_DIAM+2*2)*6/8/2+-6/2, 
        -(SOP_AGUJ_DIST_LARGO+SOP_AGUJ_DIAM+2*2)/2+4/2+87, 
        -6.5/2+SOP_AGUJ_DIST_ESPESOR
    ]) 
        cube([6, 4, 6.5], center=true);
    translate([
        (SOP_AGUJ_DIST_ANCHO+SOP_AGUJ_DIAM+2*2)*6/8/2+-4.5/2 -5-3-9 , 
        -(SOP_AGUJ_DIST_LARGO+SOP_AGUJ_DIAM+2*2)/2+4/2+87, 
        -6.5/2+SOP_AGUJ_DIST_ESPESOR
    ]) 
        cube([5+3, 4, 6.5], center=true);
}

soporte();
//lcdBoard();