//all();

//section();

Outer();

//Inner();

//Roller();

//Rollers();

//Retainer(isTop=false);
//Retainer(isTop=true);

$fn = 200;

outerRadius = 11-0.5;

innerRadius = 3.5;

wallThickness = 0.45;

width = 8;

raceLipWidth = 1.2;

raceLipHeight = raceLipWidth * tan(60);

tolerance = 0.1;


outerRaceRadius = outerRadius - wallThickness;



innerRaceRadius = innerRadius + wallThickness;


numRollers = 6;

rollerRaceLipWidth = 1;

rollerRaceLipHeight = rollerRaceLipWidth * tan(45);

rollerRaceRadius = (outerRaceRadius - innerRaceRadius)/2 - tolerance;

rollerCentreDistance = innerRaceRadius + tolerance + rollerRaceRadius;

rollerBaseHeight = raceLipHeight + tolerance;

rollerInnerRadius = rollerRaceRadius - rollerRaceLipWidth - wallThickness;

rollerMidsectionHeight = width - raceLipHeight*2 - tolerance*2;

rollerTopHeight = rollerBaseHeight + rollerMidsectionHeight + rollerRaceLipHeight;

rollerHoleRadius = rollerRaceRadius - rollerRaceLipWidth - wallThickness;


retainerBaseHeight = 0.6;

retainerBottomHeight = rollerBaseHeight - retainerBaseHeight - tolerance*2;

retainerUpperHeight = rollerTopHeight + retainerBaseHeight + tolerance*2;



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
    difference(){
        union(){
            OuterHalf();
            
            mirror([0,0,1])
            translate([0,0,-width])
            OuterHalf();
        }
        
        // hole to slide in roller
        translate([rollerCentreDistance,0,width/2])
        cylinder(width, rollerRaceRadius, rollerRaceRadius);
        
    }
    
    // bottom
    difference(){
        cylinder(wallThickness, outerRadius-raceLipWidth, outerRadius-raceLipWidth);
        
        translate([0,0,-0.01])
        cylinder(wallThickness+0.02, outerRadius-raceLipWidth-wallThickness*3, outerRadius-raceLipWidth-wallThickness*3);
    }
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
    difference(){
        union(){
            InnerHalf();
            
            mirror([0,0,1])
            translate([0,0,-width])
            InnerHalf();
        }
        
        // hole to slide in roller
        translate([rollerCentreDistance,0,width/2])
        cylinder(width, rollerRaceRadius, rollerRaceRadius);
    }
    
    // bottom
    difference(){
        cylinder(wallThickness, innerRadius+raceLipWidth, innerRadius+raceLipWidth);
        
        translate([0,0,-0.01])
        cylinder(wallThickness+0.02, innerRadius, innerRadius);
    }
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
    difference(){
        cylinder(wallThickness, rollerRaceRadius, rollerRaceRadius);
        
        translate([0,0,-0.01])
        cylinder(wallThickness+0.02, rollerHoleRadius, rollerHoleRadius);
    }
}

module Rollers(){
    translate([0,0,rollerBaseHeight])
    for (angle=[0:360/numRollers:360])
        rotate([0,0,angle])
        translate([rollerCentreDistance,0,0])
        Roller();
}

module RetainerClip(isTop=false){
    clipWidth = wallThickness * 3;
    midClipHeight = rollerRaceLipWidth/cos(45) + rollerInnerRadius/3;
    
    //mid 
    if (isTop){
        translate([0,0,retainerBaseHeight+wallThickness])
        rotate([0,45,0])
        translate([0,0,midClipHeight/2])
        cube([clipWidth,clipWidth,midClipHeight], center=true);
    }else{
            translate([0,0,retainerBaseHeight+wallThickness])
        rotate([0,-45,0])
        translate([0,0,midClipHeight/2])
        cube([clipWidth,clipWidth,midClipHeight], center=true);
    }
    
    
    baseWidth = wallThickness * 3;
    baseLength = 2*sqrt(pow(rollerHoleRadius -tolerance*3, 2) - pow(baseWidth/2, 2));
    baseHeight = wallThickness*2 + tolerance*2;
    // base
    translate([0,0,retainerBaseHeight+baseHeight/2])
    cube([baseWidth, baseLength, baseHeight], center=true);
}

module Retainer(isTop=false){
        difference(){
        cylinder(retainerBaseHeight,rollerCentreDistance+1,rollerCentreDistance+1);
        translate([0,0,-1])
        cylinder(4,rollerCentreDistance-1,rollerCentreDistance-1);
    }

    for (angle=[0:360/numRollers:360])
        rotate([0,0,angle])
        translate([rollerCentreDistance,0,0])
        RetainerClip(isTop);
}

module all(){
    Outer();
    Inner();
    Rollers();
    translate([0,0,retainerBottomHeight])
    Retainer();
    
    translate([0,0,retainerUpperHeight])
    mirror([0,0,1])
    Retainer(isTop=true);
}

module section(){
    difference(){
        all();
        
        translate([0,-500,-0.01])
        cube([500,500,500]);
    }
}


















