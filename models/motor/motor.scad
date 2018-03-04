
$fn = 50;

shaftLength = 120;

paperclipRadius = 0.5;

//Armature();

//Commutator();

SpringRing();

//Bearing();

//ToothedShaft();

//Slide();

//Assembly();

//translate([90,0,0])
//BearingHolder();

//MagnetHolderConstruction();

//cube([10,10,30]);

//BaseAssembly();

module Armature(length=20){
    
    difference(){
        union(){
            translate([0,0,length/2])
            cylinder(length,12,12, center=true);
            
            for (angle = [0:360/3:360]){
                rotate([0,0,angle]){
                    translate([11,0,length/2])
                    cube([25, 14, length], center=true);
                }
            }
            
            //outer ring
            difference(){
                cylinder(length, 25,25);
                translate([0,0,-0.01])
                cylinder(length+0.02, 23, 23);
            }
        }
        
        //centre hole
        cube([10.5,10.5,45+0.04], center=true);
        
        for (angle = [0:360/3:360]){
            rotate([0,0,angle + 360/6]){
                translate([31,0,length/2-0.01])
                cube([35, 14, length+0.04], center=true);
            }
        }
    }
}

module Commutator(){
    difference(){
        union(){
            
            cylinder(5,11,11);
            
            translate([0,0,5])
            cylinder(5,11,9);
                    
            translate([0,0,10])
            cylinder(5,9,11);
                    
            translate([0,0,15])
            cylinder(5,11,11);
        }
        cube([10.5,10.5,45+0.04], center=true);
        
        for (angle = [0:360/6:360]){
            rotate([0,0,angle])
            translate([11,0,0])
            cylinder(25, 0.5, 0.5);
            
            
            rotate([0,0,angle])
            translate([11,0,1.2])
            rotate([0,-90,0])
            cylinder(25, 0.75, 0.75);
        }
    }
}

module Bearing(){
    difference(){
        cylinder(15, 18, 18);
        
        translate([0, 0, -0.01])
        cylinder(15.02, 4.5, 4.5);
    }
}

module ToothedShaftHalf(){
    middleLength = shaftLength/2 - 20;

    // middle
    translate([0, 0, 20 + middleLength/2])
    cube([10, 10, middleLength], center=true);

    // taper
    translate([0, 0, 15])
    cylinder(5, 4.2, 5);
    
    // bottom
    cylinder(15, 4.2, 4.2);
}

module ToothedShaft(){
    ToothedShaftHalf();
    
    translate([0, 0, shaftLength])
    mirror([0, 0, 1])
    ToothedShaftHalf();
}

module Slide(height=20){
    translate([0,0,height/2])
    difference(){
        cube([12.5,12.5,height], center=true);
        translate([0,0,-0.01])
        cube([10.5,10.5,height+0.04], center=true);   
    } 
}

module MagnetHolder2(){
    translate([0,0,5])
    difference(){
        cube([12.1, 6.1,10], center=true);
        translate([0,0,-0.01])
        cube([10.1, 4.1,10.04], center=true);   
    } 
}

module MagnetHolderConstruction(){
    MagnetHolder2();
    
    translate([11.5,0,0])
    MagnetHolder2();
    
    translate([0,0,10]){
        MagnetHolder2();
        
        translate([11.5,0,0])
        MagnetHolder2();
    }
    
    translate([-6.0,-3,-25])
    cube([23.6,6.1,25]);
}

module MagnetHolderHolder(){
    translate([0,-3,-25])
    cube([5,6.1,30]);
    
    translate([29.5,-3,-25])
    cube([5,6.1,30]);
}

module BearingHolder(){
    difference(){
        translate([0, -20, 0])
        cube([20,40,40]);
        
        translate([2, -18, -1])
        cube([16, 18.2 *2, 50]);
        
        translate([-1, -15, -1])
        cube([22, 30, 50]);
    }
    
    translate([0,-2.5,0])
    cube([20,5,16]);
    
    //base support
    translate([0,-38-13,0])
    cube([5,100,5]);
    
    translate([-70,40-13,0])
    cube([70,6.1,5]);
    
    translate([-70,-20-13,0])
    cube([70,6.1,5]);
    
}

module BearingHolders(){
    translate([10,0,0])
    rotate([0,0,180])
    BearingHolder();
    
    translate([99,0,0])
    BearingHolder();
}


module BaseAssembly(){
    BearingHolders();
    
    translate([63,-30,25])
    MagnetHolderHolder();
    
    translate([63, 30,25])
    MagnetHolderHolder();

    translate([12,-10,0])
    SpringRingHolder();
}

module SpringRing(){
    difference(){
        cylinder(15,22,22);
        translate([0,0,-0.5])
        cylinder(16,20,20);
        
        //tiny holes
        for (angle = [0:360/16:360]){           
            translate([0,0,13])
            rotate([0,0,angle])
            rotate([90,0,0])
            cylinder(50,0.75,0.75, center=true);
        }
    }
}


module SpringRingHolder(){
    difference(){
        cube([15,20,30]);
        translate([0,10,34.6])
        rotate([0,90,0])
        cylinder(50,22,22);
    }
    
    translate([-5,15,0])
    cube([10,5 ,5]);
    
    translate([-5,-0,0])
    cube([10, 5, 5]);
}


module Assembly(){
    translate([0,0,35])
    rotate([0,90,0]){
        translate([0,0,-7])
        Bearing();
        
        translate([0,0,-6])
        ToothedShaft();
        
        translate([0,0,22])
        Commutator();
        
        translate([0,0,12])
        SpringRing();
        
        translate([0,0,70])
        Armature();
        
        translate([0,0,shaftLength-19])
        Bearing();   
    }

    BaseAssembly();
    
    translate([74.5,30,25])
    MagnetHolderConstruction();
    
    translate([74.5,-30,25])
    MagnetHolderConstruction();
}

























