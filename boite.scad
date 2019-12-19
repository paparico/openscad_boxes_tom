
module u(l=25,ep=1.5,jour=5,h=5){
    difference(){
        cube([l,jour+2*ep,h],false);
        translate([ep,ep,-1])
            cube([l-ep+1,jour,h+1.5],false);
    } 
}
//u();
module angle(ep=1.5,jour=5,h=5,r=25,epFond=2){
    translate([0,-2*ep-jour,0])
    intersection(){
		translate([0,2*ep+jour,0]) difference() {	cylinder(r=r,h=h*4,center=true,$fn=128);
			translate([ep,ep+0.1-r-jour-2*ep,epFond])cube([jour,r,h]);
		}
        difference(){
            union(){
                u(2*r,ep,jour,h);
                translate([0,ep,0]) rotate(-90)
                    u(2*r-(2*ep+jour),ep,jour,h);
                translate([0,2*ep+jour,0])
                    cylinder(r=r*1.5,h=epFond);
            }
            translate([-r,0,0])cube([2*r,4*r,3*h],center=true);
            translate([0,2*ep+jour+r,0])cube([4*r,2*r,3*h],center=true);
        }
    }
 
}
angle(epFond=2,r=35,h=25);

module angleHaut(ep=1.5,jour=5,h=5,r=25,epToit=2){
    translate([-ep-jour,-ep,0])
	difference() {
		union(){
				u(r,ep,jour,h);
				translate([0,ep,0]) rotate(-90)
					u(r-(2*ep+jour),ep,jour,h);
				translate([0,0,h-epToit])
					cube([r,2*ep+jour,epToit]);
				translate([0,-r+3*ep+jour,h-epToit])
					cube([2*ep+jour,r-3*ep-jour,epToit]);
			}
		
			translate([ep,-r+ep+1,epToit*-1])
			cube([jour,r,h]);
		}
        
}
angleHaut(h=15,epToit=2);
    

module pane(xL,yL){
    color ([0,1,0,0.5]) cube([xL,yL,5],false);
    }
//pane(65,100);
slack=epParoi-0.8;
L_pane= yInt+jour+epParoi+slack;
l_pane=	xInt+jour+epParoi+slack;

    
module etai(epPied=3,xInt=65,jour=0.95*5,epParoi=1.5,h=30,l=20){
	l_etai= xInt+jour*2+epParoi*4;
    translate([0,0,0])rotate([0,-90,-90])u(l,epParoi,jour,h);
    translate([xInt+jour+epParoi*2,0,0])rotate([0,-90,-90])u(l,epParoi,jour,h);
    translate([0,0,0])cube([l_etai,h,epPied],false);
    }


module machoire(longC=40,longU=15,epU=1.5,jour=5,rC=5,rT=3,male=true){ 
    translate([])rotate([])union(){
        u(l=longU,ep=epU,jour=jour,h=longC);
        #translate([-rC+epU/2,(2*epU+jour)/2,])
        difference(){
            
            if(male){
                translate([0,0,longC/3])cylinder(r=rC,h=longC/3,$fn=128);
                }
                else{
                    cylinder(r=rC,h=longC/3,$fn=128);
                    translate([0,0,2*longC/3])cylinder(r=rC,h=longC/3,$fn=128);
                    }
            
            
            
            translate([0,0,-0.5])cylinder(r=rT,h=longC+10,center=false,$fn=128);
            
            
        }
    }
}
//machoire(male=false);

module boite(epPane=5,xInt=65,yInt=500,zInt=90,epParoi=1.5,hAngle=30,rAngle=20,epFond=3,epToit=3){
    jour=0.95*epPane;
    decalage=epParoi+jour;
    %color ([0,0,1,0.2])cube([xInt,yInt,zInt],false);
    
    translate([-decalage,-decalage,-epFond-epPane])rotate(90)
    angle(ep=epParoi,jour=jour,h=hAngle,r=rAngle,epFond=epFond);
    
    translate([-decalage,yInt+decalage,-epFond-epPane])rotate(0)angle(ep=epParoi,jour=jour,h=hAngle,r=rAngle,epFond=epFond);
    
    translate([xInt+decalage,decalage+yInt,-epFond-epPane])rotate(270)angle(ep=epParoi,jour=jour,h=hAngle,r=rAngle,epFond=epFond);
    
    translate([xInt+decalage,-decalage,-epFond-epPane])rotate(180)angle(ep=epParoi,jour=jour,h=hAngle,r=rAngle,epFond=epFond);
    
    translate([0,0,-epPane])pane(xInt,yInt);
    
    translate([epParoi,0,-epPane])rotate([90,0,0])pane(xInt+epPane-epParoi,zInt+epPane);
    translate([0,-epPane,-epPane])rotate([0,-90,0])pane(zInt+epPane,yInt-epParoi+epPane);
    translate([-epPane,yInt+epPane,-epPane])rotate([90,0,0])pane(xInt+epPane-epParoi,zInt+epPane);
    translate([xInt+epPane,epParoi,-epPane])rotate([0,-90,0])pane(zInt+epPane,yInt-epParoi+epPane);
    
    translate([0,yInt,zInt-hAngle+epToit])angleHaut(ep=epParoi,jour=jour,h=hAngle,r=rAngle,epToit=epFond);
    
    translate([xInt,yInt,zInt-hAngle+epToit])rotate(-90)angleHaut(ep=epParoi,jour=jour,h=hAngle,r=rAngle,epToit=epFond);
    
    translate([xInt,0,zInt-hAngle+epToit])rotate(-180)angleHaut(ep=epParoi,jour=jour,h=hAngle,r=rAngle,epToit=epFond);
    
    translate([0,0,zInt-hAngle+epToit])rotate(-270)angleHaut(ep=epParoi,jour=jour,h=hAngle,r=rAngle,epToit=epFond);
    
    //translate([0,(yInt+epPane)/2,zInt])rotate([90,,])machoire(longC=40,longU=15,epU=epParoi,jour=jour,rC=5,rT=3,male=true);
    
    //translate([0,(yInt+epPane)/2,zInt])rotate([90,,])machoire(longC=40,longU=15,epU=epParoi,jour=jour,rC=5,rT=3,male=false);
    
    
    }
boite();
angle(h=20,r=25,epfond=2.5,jour=0.95*5);	
etai(epPied=2.5,xInt=65,jour=0.95*5,epParoi=1.5,h=20,l=20);
!etai(epPied=2.5,xInt=65,jour=0.98*5,epParoi=1.5,h=20,l=20);