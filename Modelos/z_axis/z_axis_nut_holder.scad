
TUERCA_ALTO         = 7+1;
TUERCA_DIAM         = 14.5+1;

VARILLA_DIAM        = 8+1.5;

SOP_AGUJ_DIAM       = 3+0.5;
SOP_AGUJ_DIST       = 16;
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
            cylinder(d=VARILLA_DIAM, h=SOP_ALTO*2);
            translate([0,0,SOP_PARED_ESP]) cylinder(d=TUERCA_DIAM, h=TUERCA_ALTO, $fn=6);
            for (i=[[0,1],[1,0],[0,-1],[-1,0]]) {
                translate([i[0]*SOP_AGUJ_DIST/2, i[1]*SOP_AGUJ_DIST/2, 0]) 
                    cylinder(d=SOP_AGUJ_DIAM, h=SOP_ALTO, $fn=20);
            }
        }
    }
}

tuercaSoporte();