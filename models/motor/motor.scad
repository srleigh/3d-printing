
$fn = 200;

shaftLength = 150;

Bearing();

ToothedShaft();

translate([20,0,0])
Slide();

translate([-40,0,0])
MagnetHolder();

translate([-75,100,0])
Assembly();


translate([0,-90,0])
CoilHolder();

module Bearing()
{
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

module MagnetHolder(){
    Slide(10);
    
    translate([8.3,0,5])
    difference(){
        cube([6.1,12.1,10], center=true);
        translate([0,0,-0.01])
        cube([4.1,10.1,10.04], center=true);   
    } 
    
    translate([-8.3,0,5])
    difference(){
        cube([6.1,12.1,10], center=true);
        translate([0,0,-0.01])
        cube([4.1,10.1,10.04], center=true);   
    } 
    
    translate([0,8.3,5])
    difference(){
        cube([12.1, 6.1,10], center=true);
        translate([0,0,-0.01])
        cube([10.1, 4.1,10.04], center=true);   
    } 
    
    translate([0,-8.3,5])
    difference(){
        cube([12.1, 6.1,10], center=true);
        translate([0,0,-0.01])
        cube([10.1, 4.1,10.04], center=true);   
    } 
    
}

module CoilHolder(){
    cube([50,20,30]);
    
    translate([-10,0,0])
    cube([70,5,30]);
    
    translate([-10,20,0])
    cube([70,5,30]);
}

module Assembly(){
    translate([0,0,40])
    rotate([0,90,0]){
        Bearing();
        
        translate([0,0,70])
        MagnetHolder();
        
        ToothedShaft();
        
        translate([0,0,shaftLength-7])
        Bearing();
    }
    
    translate([50,-30,3])
    rotate([45,0,0])
    CoilHolder();
    
    translate([50,10,20])
    rotate([-45,0,0])
    CoilHolder();
}

























