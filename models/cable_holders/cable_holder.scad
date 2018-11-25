
$fn=50;


color("silver")
//minkowski(){
    difference(){
        cylinder(r=12,h=5);
        
        translate([0,0,-1]){
        cylinder(r=11.5,h=12);
            
        translate([0,0,5])
        rotate([35,0,0])
        translate([0,-2,-20])
        cube([40,4,40]);
        }
    }
    //cylinder(r=2,h=1);
    
    sphere(r=1, $fn=15);
//}


            