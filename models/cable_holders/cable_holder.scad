
$fn=6;  //Set to 50 for good circular renders  


color("silver")
difference(){
    minkowski(){
        difference(){
            cylinder(r=9,h=7);
            
            translate([0,0,-1]){
            cylinder(r=8.9,h=12);
            
            rotate([0,0,-33])
            translate([0,0,5])
            rotate([35,0,0])
            translate([0,-1.25,-20])
            cube([40,2.5,40]);
            }
        }
        sphere(r=0.6, $fn=15);  //Set to 15 for good renders
    }
    translate([-40,-40,-1.5])
    cube([80,80,1]);
}


            