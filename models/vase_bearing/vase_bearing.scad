$fn = 200;

outerRadius = 11;

innerRadius = 4;

wallThickness = 0.4;

width = 8;

raceLipWidth = 1.5;

raceLipHeight = raceLipWidth * tan(60);

tolerance = 0.1;


outerRaceRadius = outerRadius - wallThickness;



innerRaceRadius = innerRadius + wallThickness;


numRollers = 7;

rollerRaceLipWidth = 1;

rollerRaceLipHeight = rollerRaceLipWidth * tan(45);

rollerRaceRadius = (outerRaceRadius - innerRaceRadius)/2 - tolerance;

rollerCentreDistance = innerRaceRadius + tolerance + rollerRaceRadius;

rollerBaseHeight = raceLipHeight + tolerance;

rollerInnerRadius = rollerRaceRadius - rollerRaceLipWidth - wallThickness;


retainerBaseHeight = 0.6;



module OuterHalf(){
    halfWidth = width / 2 - raceLipHeight;
    
    //mid section
    translate([0,0,raceLipHeight])
    difference(){
        cylinder(halfWidth, outerRadius, outerRadius);
        
        translate([0,0,-0.01])
        cylinder(halfWidth+0.02, outerRaceRadius, outerRaceRadius);
    }
    
    //lip
    difference(){
        cylinder(raceLipHeight, outerRadius-raceLipWidth, outerRadius);
        
        translate([0,0,-0.01])
        cylinder(raceLipHeight+0.02, outerRaceRadius-raceLipWidth, outerRaceRadius);
        
    }
}

module Outer(){
    OuterHalf();
    
    mirror([0,0,1])
    translate([0,0,-width])
    OuterHalf();
}

module InnerHalf(){
    halfWidth = width / 2 - raceLipHeight;
    
    //mid section
    translate([0,0,raceLipHeight])
    difference(){
        cylinder(halfWidth, innerRaceRadius, innerRaceRadius);
        
        translate([0,0,-0.01])
        cylinder(halfWidth+0.02, innerRadius, innerRadius);
    }
    
    //lip
    difference(){
        cylinder(raceLipHeight, innerRaceRadius + raceLipWidth, innerRaceRadius);
        
        translate([0,0,-0.01])
        cylinder(raceLipHeight+0.02, innerRadius + raceLipWidth, innerRadius);
        
    }
    
}

module Inner(){
    InnerHalf();
    
    mirror([0,0,1])
    translate([0,0,-width])
    InnerHalf();
}

module Roller(){
    rollerMidsectionHeight = width - raceLipHeight*2 - tolerance*2;
    
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
    difference(){
        cylinder(wallThickness, rollerRaceRadius, rollerRaceRadius);
        
        translate([0,0,-0.01])
        cylinder(wallThickness+0.02, rollerRaceRadius - rollerRaceLipWidth - wallThickness, rollerRaceRadius - rollerRaceLipWidth - wallThickness);
    }
    
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
    midClipHeight = rollerRaceLipWidth/cos(45);
    
    //top

    //mid 
    translate([-midClipHeight/2,0,retainerBaseHeight+midClipHeight+wallThickness])
    rotate([0,-45,0])
    cube([clipWidth,clipWidth,midClipHeight], center=true);
    
    baseWidth = wallThickness * 3;
    baseLength = 2*sqrt(pow(rollerInnerRadius -tolerance*2, 2) - pow(baseWidth, 2));
    baseHeight = 2;
    // base
    translate([0,0,retainerBaseHeight+baseHeight/2])
    cube([baseWidth, baseLength, baseHeight], center=true);
}

module Retainer(){
        difference(){
        cylinder(retainerBaseHeight,rollerCentreDistance+1,rollerCentreDistance+1);
        translate([0,0,-1])
        cylinder(4,rollerCentreDistance-1,rollerCentreDistance-1);
    }

    for (angle=[0:360/numRollers:360])
        rotate([0,0,angle])
        translate([rollerCentreDistance,0,0])
        RetainerClip();
}



//Outer();

//Inner();

//Roller();

//Rollers();

Retainer();
















