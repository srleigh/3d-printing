
$fn = 200;

shaftLength = 110;

//Bearing();

//ToothedShaft();

//translate([20,0,0])
//Slide();
//
//translate([-40,0,0])
//MagnetHolder();
//
//translate([-75,100,0])
//Assembly();
//
//
//translate([0,-90,0])
//CoilHolder();
//
//translate([90,0,0])
//BearingHolder();
//
translate([-80,30,0])
Cam();

//cube([10,10,30]);

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

module CoilHolder(){
    difference(){
        union(){
            cube([30,20,30]);
            
            translate([-10,0,0])
            cube([50,5,30]);
            
            translate([-10,2.5,0])
            cylinder(30,2.5,2.5);
            
            translate([40,2.5,0])
            cylinder(30,2.5,2.5);
            
            translate([-10,22.5,0])
            cylinder(30,2.5,2.5);
            
            translate([40,22.5,0])
            cylinder(30,2.5,2.5);
            
            translate([-10,20,0])
            cube([50,5,30]);
            
            rotate([45,0,0])
            cube([30,30*cos(45),30*cos(45)]);
        }
    
        translate([4,4.5,-1])
        cube([22,15.5,32]);
        
        translate([4,-16,-1])
        cube([22,16,32]);
    }
}

module BearingHolder(){
    translate([0,0,80])
    rotate([0,90,0])
    difference(){
        cube([80,26,11]);
        translate([-11,(26-22.2)/2,(11-7.2)/2])
        cube([70, 22.2, 7.2]);
        
        translate([-11,(26-16)/2,-1])
        cube([70, 16, 13]);
    }
    
    difference(){
        translate([20,13,0])
        cylinder(4, 30, 30);
        
        translate([25,13,-1])
        cylinder(6, 18, 18);
        
    }
}

module Cam(angle=0){
    Slide(5);
    
    difference(){
        rotate([0,0,angle])
        scale([1,0.8,1])
        {
            translate([0,0,2.5])
            cylinder(2.5,19,20);
            
            cylinder(2.5,20,19);
        }
        
        translate([-6,-6,-1])
        cube([12,12,20]);
    }
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
    
    translate([50,50,25])
    rotate([-45,180,180])
    CoilHolder();
    
    translate([10,13,0])
    rotate([0,0,180])
    BearingHolder();
    
    translate([100,-13,0])
    BearingHolder();
    
    translate([20,0,40])
    rotate([0,90,0])
    Cam();
    
    translate([25,0,40])
    rotate([90,0,0])
    rotate([0,90,0])
    Cam();
    
    translate([30,0,40])
    rotate([0,90,0])
    Cam();
    
    translate([35,0,40])
    rotate([90,0,0])
    rotate([0,90,0])
    Cam();
}

























