
TUERCA_ALTO         = 10;
TUERCA_DIAM         = 15;

VARILLA_DIAM        = 10;

SOP_AGUJ_DIAM       = 3;
SOP_AGUJ_DIST       = 20;
SOP_PARED_ESP       = 3;
SOP_ALTO            = TUERCA_ALTO+SOP_PARED_ESP;
SOP_DIAM            = SOP_AGUJ_DIST+SOP_AGUJ_DIAM+SOP_PARED_ESP;


module tuercaSoporte()
{
    difference() {
        union() {
            cylinder(d=SOP_DIAM, h=SOP_ALTO);
        }
        color("red", 0.5) {
            translate([0,0,SOP_PARED_ESP]) cylinder(d=TUERCA_DIAM, h=TUERCA_ALTO, $fn=6);
            for (i=[[0,1],[1,0],[0,-1],[-1,0]]) {
                translate([i[0]*SOP_AGUJ_DIST/2, i[1]*SOP_AGUJ_DIST/2, 0]) 
                    cylinder(d=SOP_AGUJ_DIAM, h=SOP_ALTO, $fn=20);
            }
        }
    }
}

tuercaSoporte();