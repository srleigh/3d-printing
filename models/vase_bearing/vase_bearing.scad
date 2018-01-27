//All();
//Section();
//Outer();
//Inner();
//Roller();
//Rollers();
Retainer();

$fn = 200;

outerRadius = 11;

innerRadius = 3.5;

wallThickness = 0.45;

width = 8;

tolerance = 0.1;


raceUpperLipWidth = 1.2;

raceUpperLipHeight = raceUpperLipWidth * tan(60);

raceLowerLipWidth = 0.8;

raceLowerLipHeight = raceLowerLipWidth * tan(60);


outerRaceRadius = outerRadius - wallThickness;



innerRaceRadius = innerRadius + wallThickness;


rollerRaceLipWidth = 1.4;

rollerRaceLipHeight = rollerRaceLipWidth * tan(45);

rollerRaceRadius = (outerRaceRadius - innerRaceRadius)/2 - tolerance;

rollerCentreDistance = innerRaceRadius + tolerance + rollerRaceRadius;

rollerBaseHeight = raceLowerLipHeight + tolerance;

rollerInnerRadius = rollerRaceRadius - rollerRaceLipWidth - wallThickness;

rollerMidsectionHeight = width - raceUpperLipHeight - raceLowerLipHeight - tolerance*2;

rollerTopHeight = rollerBaseHeight + rollerMidsectionHeight + rollerRaceLipHeight;

rollerHoleRadius = rollerRaceRadius - rollerRaceLipWidth - wallThickness;

numRollers = floor(PI * rollerCentreDistance * 2 / (rollerRaceRadius*2 + tolerance * 4));

echo (numRollers=numRollers);


retainerBaseHeight = 0.4;

retainerBottomHeight = rollerBaseHeight - retainerBaseHeight - tolerance*2;

retainerUpperHeight = rollerTopHeight + retainerBaseHeight + tolerance*2;


module Ring(height, lowerRadius, upperRadius, thickness){
    difference(){
        cylinder(height, lowerRadius, upperRadius);
        
        translate([0,0,-0.01])
        cylinder(height+0.02, lowerRadius - thickness, upperRadius - thickness);
    }
}


module OuterHalf(raceLipHeight, raceLipWidth){
    partWidth = width - raceUpperLipHeight - raceLowerLipHeight;
    
    //mid section
    translate([0, 0, raceLipHeight])
    Ring(partWidth, outerRadius, outerRadius, wallThickness);
    
    //lip
    Ring(raceLipHeight, outerRadius - raceLipWidth, outerRadius, wallThickness);
 }

module Outer(){
    difference(){
        union(){
            OuterHalf(raceLowerLipHeight, raceLowerLipWidth);
            
            mirror([0,0,1])
            translate([0,0,-width])
            OuterHalf(raceUpperLipHeight, raceUpperLipWidth);
        }
        
        // hole to slide in roller
        translate([rollerCentreDistance,0,width/2])
        cylinder(width, rollerRaceRadius, rollerRaceRadius);
        
    }
    
    // bottom
    Ring(wallThickness, outerRadius - raceLowerLipWidth, outerRadius - raceLowerLipWidth, wallThickness*3);
}

module InnerHalf(raceLipHeight, raceLipWidth){
    partWidth = width - raceUpperLipHeight - raceLowerLipHeight;
    
    //mid section
    translate([0,0,raceLipHeight])
    Ring(partWidth, innerRaceRadius, innerRaceRadius, wallThickness);

    //lip
    Ring(raceLipHeight, innerRaceRadius + raceLipWidth, innerRaceRadius, wallThickness);    
}

module Inner(){
    difference(){
        union(){
            InnerHalf(raceLowerLipHeight, raceLowerLipWidth);
            
            mirror([0,0,1])
            translate([0,0,-width])
            InnerHalf(raceUpperLipHeight, raceUpperLipWidth);
        }
        
        // hole to slide in roller
        translate([rollerCentreDistance,0,width/2])
        cylinder(width, rollerRaceRadius, rollerRaceRadius);
    }
    
    // bottom
    Ring(wallThickness, innerRadius + raceLowerLipWidth, innerRadius + raceLowerLipWidth, raceLowerLipWidth);
}

module Roller(){   
    //lip
    translate([0,0,rollerMidsectionHeight])
    difference(){
        cylinder(rollerRaceLipHeight, rollerRaceRadius, rollerRaceRadius -rollerRaceLipWidth);
        
        translate([0,0,-0.01])
        cylinder(rollerRaceLipHeight+0.02, rollerRaceRadius - wallThickness, rollerRaceRadius -rollerRaceLipWidth - wallThickness);
    }
    
    //mid section
    difference(){
        cylinder(rollerMidsectionHeight, rollerRaceRadius, rollerRaceRadius);
        
        translate([0,0,-0.01])
        cylinder(rollerMidsectionHeight+0.02, rollerRaceRadius - wallThickness, rollerRaceRadius - wallThickness);
    }
    
    //bottom
    Ring(wallThickness, rollerRaceRadius, rollerRaceRadius, rollerRaceRadius - rollerHoleRadius);
}

module Rollers(){
    translate([0,0,rollerBaseHeight])
    for (angle=[0:360/numRollers:360])
        rotate([0,0,angle])
        translate([rollerCentreDistance,0,0])
        Roller();
}

module RetainerClip(){
    clipWidth = wallThickness * 3;
    midClipHeight = (rollerRaceRadius-wallThickness)/cos(45)/1.8;
    
    //mid 
    translate([0,0,retainerBaseHeight+wallThickness + tolerance*2])
    rotate([0,-45,0])
    translate([0,0,midClipHeight/2])
    cube([clipWidth,clipWidth,midClipHeight], center=true);
    
    baseWidth = wallThickness * 3;
    baseLength = 2*sqrt(pow(rollerHoleRadius -tolerance*3, 2) - pow(baseWidth/2, 2));
    baseHeight = wallThickness*3 + tolerance*2;
    // base
    translate([0,0,retainerBaseHeight+baseHeight/2])
    cube([baseWidth, baseLength, baseHeight], center=true);
}

module Retainer(){
    Ring(retainerBaseHeight, rollerCentreDistance+0.8, rollerCentreDistance+0.8, 1.6);

    for (angle=[0:360/numRollers:360])
        rotate([0,0,angle])
        translate([rollerCentreDistance,0,0])
        RetainerClip();
}

module All(){
    Outer();
    Inner();
    Rollers();
    translate([0,0,retainerBottomHeight])
    Retainer();
    
    translate([0,0,retainerUpperHeight])
    mirror([0,0,1])
    Retainer(isTop=false);
}

module Section(){
    difference(){
        All();
        
        translate([0,-500,-0.01])
        cube([500,500,500]);
    }
}


















