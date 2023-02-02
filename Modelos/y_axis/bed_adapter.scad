CAMA_CALIENTE_DIAM_AGUJ = 3;
CAMA_CALIENTE_MARGEN    = 5;
CAMA_CALIENTE_ALTO      = 2;
CAMA_CALIENTE_DIST_AGUJ = 200;

BASE_Z_DIST_AGUJ        = 170;
BASE_Z_DIAM_AGUJ        = 3;
BASE_Z_CAB_TOR_DIAM     = 5;
BASE_Z_CAB_TOR_ALTO     = 3;

ADAPTADOR_MARGEN        = 5;
ADAPTADOR_ALTO          = 3+BASE_Z_CAB_TOR_ALTO+CAMA_CALIENTE_ALTO;


$fn = 20;

module adaptador()
{
    difference(){
        union() {
            translate([-CAMA_CALIENTE_MARGEN*2, -CAMA_CALIENTE_MARGEN*2, 0]) cube([
                (CAMA_CALIENTE_DIST_AGUJ/2)-(BASE_Z_DIST_AGUJ/2) + CAMA_CALIENTE_MARGEN *4,
                (CAMA_CALIENTE_DIST_AGUJ/2)-(BASE_Z_DIST_AGUJ/2) + CAMA_CALIENTE_MARGEN *4,
                ADAPTADOR_ALTO
            ]);
        }
        color("red", 0.5) {
            cylinder(h=50, d=BASE_Z_DIAM_AGUJ);
            translate([(CAMA_CALIENTE_DIST_AGUJ/2)-(BASE_Z_DIST_AGUJ/2), (CAMA_CALIENTE_DIST_AGUJ/2)-(BASE_Z_DIST_AGUJ/2)]) 
                cylinder(h=50, d=CAMA_CALIENTE_DIAM_AGUJ);
            translate([-CAMA_CALIENTE_MARGEN*2, -CAMA_CALIENTE_MARGEN*2, ADAPTADOR_ALTO-CAMA_CALIENTE_ALTO])
                cube([
                    (CAMA_CALIENTE_DIST_AGUJ/2)-(BASE_Z_DIST_AGUJ/2) + CAMA_CALIENTE_MARGEN *3,
                    (CAMA_CALIENTE_DIST_AGUJ/2)-(BASE_Z_DIST_AGUJ/2) + CAMA_CALIENTE_MARGEN *3,
                    10
                ]);
        color("blue") translate([0,0,ADAPTADOR_ALTO-CAMA_CALIENTE_ALTO-BASE_Z_CAB_TOR_ALTO/2]) rotate([0,0,45])
            cube([BASE_Z_DIAM_AGUJ, BASE_Z_CAB_TOR_DIAM, BASE_Z_CAB_TOR_ALTO], center=true);
        }
    }
}

adaptador();
