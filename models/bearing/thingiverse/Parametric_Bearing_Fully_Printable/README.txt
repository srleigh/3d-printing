                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


https://www.thingiverse.com/thing:2763544
Parametric Bearing (Fully Printable) by joekeur is licensed under the Creative Commons - Attribution license.
http://creativecommons.org/licenses/by/3.0/

# Summary

This is a highly customizable, fully printable bearing.  It can be printed with a fairly low end printer (I use Anet A8) and still work because it can be cleaned up before assembling.  It also doesn't require any supports and likely no raft/brims.

Obviously it doesn't spin as well as a bearing made of metal, but I think it is still good enough for light applications.  Here is a video to see how well it spins: https://youtu.be/E3SVvrHNiLI

I haven't tested many parameter combinations (there are millions), but I've chosen default settings that seem to work pretty well.  For other parameters take a look at the 'section' view to make sure things look ok before printing.

The latest version I've uploaded fixes some minor tolerance issues, and gives better default values for the customizer.

# Print Settings

Printer: Anet A8
Resolution: 0.2

Notes: 
Print all parts separately.  Don't forget to print enough rollers and two retainers.  

I've had a bit better results by using a 'One at a Time' print sequence.  This can reduce retraction artifacts.

These are the current default parameters.  The STL files were generated using these values:

// Outer radius
outerRadius = 18;  //[14:0.5:50]
// Inner radius
innerRadius = 6;  //[3.5:0.5:45]
// Width
width = 13;  //[10:0.5:50]
// Tolerance (extra space between rollers and races)
tolerance = 0.2;  //[0.05:0.05:0.5]
// Number of rollers
numRollers = 7;  //[3:50]

/* [Advanced] */
// Thickness of walls (should be a multiple of your nozzle diameter)
wallThickness = 0.8;  //[0.1:0.1:5]
raceLipWidth = 2;
rollerHoleRadius = 2;
retainerBaseHeight = 0.6;  //[0.2:0.1:1]

# Post-Printing

<iframe src="//www.youtube.com/embed/E3SVvrHNiLI" frameborder="0" allowfullscreen></iframe>
5 Rollers

No additional materials required for assembly, it snaps together.  I found it easiest to put the inner, outer and one retainer in place, then slide each roller through the slot, then put the final retainer on.  Cleanup and assembly have taken me about 15 min.

<iframe src="//www.youtube.com/embed/x_XKtQ5TxtI" frameborder="0" allowfullscreen></iframe>
7 Rollers