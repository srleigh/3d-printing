
$fn = 200;

shaftLength = 120;

paperclipRadius = 0.5;

//Armature();

//Commutator();

//Bearing();

//ToothedShaft();

//translate([20,0,0])
//Slide();
//
//translate([-40,0,0])
//MagnetHolder();
//
//translate([-75,100,0])
Assembly();
//
//
//translate([0,-90,0])
//CoilHolder();
//
//translate([90,0,0])
//BearingHolder();
//
//translate([-80,30,0])
//Cam();

//cube([10,10,30]);

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
        cylinder(7, 11, 11);
        
        translate([0, 0, -0.01])
        cylinder(7.02, 4, 4);
    }
}

module ToothedShaftHalf(){
    middleLength = shaftLength/2 - 20;

    // middle
    translate([0, 0, 20 + middleLength/2])
    cube([10, 10, middleLength], center=true);

    // taper
    translate([0, 0, 15])
    cylinder(5, 3.8, 5);
    
    // bottom
    cylinder(15, 3.8, 3.8);
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

module MagnetHolder(){
    Slide(10);
    
    translate([8.31,0,5])
    difference(){
        cube([6.1,12.1,10], center=true);
        translate([0,0,-0.01])
        cube([4.1,10.1,10.04], center=true);   
    } 
    
    translate([-8.31,0,5])
    difference(){
        cube([6.1,12.1,10], center=true);
        translate([0,0,-0.01])
        cube([4.1,10.1,10.04], center=true);   
    } 
    
    translate([0,8.31,5])
    difference(){
        cube([12.1, 6.1,10], center=true);
        translate([0,0,-0.01])
        cube([10.1, 4.1,10.04], center=true);   
    } 
    
    translate([0,-8.31,5])
    difference(){
        cube([12.1, 6.1,10], center=true);
        translate([0,0,-0.01])
        cube([10.1, 4.1,10.04], center=true);   
    } 
    
}


module BearingHolder(){
    translate([0,0,40])
    rotate([0,90,0])
    difference(){
        cube([40,26,11]);
        translate([-33,(26-22.4)/2,(11-7.4)/2])
        cube([50, 22.4, 7.4]);
        
        translate([-33,(26-16)/2,-1])
        cube([50, 16, 13]);
    }
    
    //base support
    translate([0,-38,0])
    cube([5,100,5]);
    
    translate([-70,40,0])
    cube([70,6.1,5]);
    
    translate([-70,-20,0])
    cube([70,6.1,5]);
    
}

module BearingHolders(){
    translate([10,26,0])
    rotate([0,0,180])
    BearingHolder();
    
    translate([99,0,0])
    BearingHolder();
    
}


module BaseAssembly(){
    translate([0,-13,0])
    BearingHolders();
    
    translate([74.5,30,25])
    MagnetHolderConstruction();
    
    
    translate([74.5,-30,25])
    rotate([0,0,0])
    MagnetHolderConstruction();
    
    
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
        translate([0,10,34])
        rotate([0,90,0])
        cylinder(50,22,22);
    }
    
    translate([-10,15,0])
    cube([10,5 ,5]);
    
    translate([-10,-0,0])
    cube([10,5 ,5]);
}


module Assembly(){
    translate([0,0,35])
    rotate([0,90,0]){
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
}

























