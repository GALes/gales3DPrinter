
RODAM_DIAM              = 16+1;
RODAM_DIST_PERFIL       = 21;

PERF_RANURA_ANCHO       = 6.3-0.5;
PERF_RANURA_PROF        = 5;

SOP_PARED_ESP           = 3;
SOP_ANCHO               = 35;
SOP_ALTO                = 20;
SOP_GUIA_RANURA_ANCHO   = SOP_ANCHO/4;
SOP_TORN_DIAM           = 4+.8;


module zAxisTopGuide()
{
    difference() {
        union() {
            hull() {
                translate([0,SOP_PARED_ESP/2,SOP_PARED_ESP/2]) cube([SOP_ANCHO, SOP_PARED_ESP, SOP_PARED_ESP], center=true);
                translate([0,RODAM_DIST_PERFIL+RODAM_DIAM/2]) cylinder(d=RODAM_DIAM+SOP_PARED_ESP*2, h=SOP_PARED_ESP);
            }
            translate([0,SOP_PARED_ESP/2,SOP_ALTO/2]) cube([SOP_ANCHO, SOP_PARED_ESP, SOP_ALTO], center=true);
            translate([0,RODAM_DIST_PERFIL+RODAM_DIAM/2]) cylinder(d=RODAM_DIAM+SOP_PARED_ESP*2, h=SOP_PARED_ESP*2);
            for(i=[-1,1]) {
                hull() {
                    translate([(SOP_ANCHO/2-SOP_PARED_ESP/2)*i,SOP_PARED_ESP/2,SOP_ALTO/2]) 
                        cube([SOP_PARED_ESP,SOP_PARED_ESP,SOP_ALTO], center=true);
                    translate([(RODAM_DIAM/2+SOP_PARED_ESP/2)*i,RODAM_DIST_PERFIL+RODAM_DIAM/2-SOP_PARED_ESP/2,SOP_PARED_ESP*3/2]) 
                        cube([SOP_PARED_ESP,SOP_PARED_ESP,SOP_PARED_ESP], center=true);
                }
                translate([(SOP_ANCHO/2-SOP_GUIA_RANURA_ANCHO/2)*i,-PERF_RANURA_PROF/2,SOP_ALTO/2]) 
                    cube([SOP_GUIA_RANURA_ANCHO, PERF_RANURA_ANCHO, PERF_RANURA_PROF], center=true);
            }
        }
        color("red", 0.5) {
            translate([0,RODAM_DIST_PERFIL+RODAM_DIAM/2]) cylinder(d=RODAM_DIAM, h=SOP_PARED_ESP*2);
            translate([0,20/2,SOP_ALTO/2]) rotate([90,0,0]) cylinder(d=SOP_TORN_DIAM, h=20, $fn=10);
        }
    }
}

zAxisTopGuide();