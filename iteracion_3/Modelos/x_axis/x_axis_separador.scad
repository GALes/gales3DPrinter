ANCHO               = 40;
ALTO                = 31;
PROFUNDIDAD         = 6;
MONT_AGUJ_TOP_DIST  = 6;
MONT_AGUJ_DIST      = 20;
MONT_AGUJ_DIAM      = 3+1;

module Separador()
{
    difference() {
        union() {
            translate([0, 0, PROFUNDIDAD/2]) cube([ALTO, ANCHO, PROFUNDIDAD], center = true);
        }
        for( i = [-1, 1] ) {
            translate([ALTO/2-MONT_AGUJ_TOP_DIST, MONT_AGUJ_DIST/2*i, 0]) # cylinder(d=MONT_AGUJ_DIAM, h=PROFUNDIDAD, $fn=15);
        }
    }
}

Separador();

