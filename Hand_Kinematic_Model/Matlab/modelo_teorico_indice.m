%%MODELO CINEMÁTICO TEÓRICO DEDO INDICE
clc
clear all

%Posición
qi1=0; qi2=0; qi3=-0.5; qi4=-0.5; qi5=-0.5;

% Ti(0-1)
di1=0; ai1=46.53; afi1=(-90);

Ti01=[cos(qi1) -sin(qi1)*cosd(afi1) sin(qi1)*sind(afi1) ai1*cos(qi1); 
     sin(qi1) cos(qi1)*cosd(afi1) -cos(qi1)*sind(afi1) ai1*sin(qi1); 
     0 sind(afi1) cosd(afi1) di1; 
     0 0 0 1];
 
% Ti(1-2)
di2=0; ai2=0; afi2=90;

Ti12=[cos(qi2) -sin(qi2)*cosd(afi2) sin(qi2)*sind(afi2) ai2*cos(qi2); 
     sin(qi2) cos(qi2)*cosd(afi2) -cos(qi2)*sind(afi2) ai2*sin(qi2); 
     0 sind(afi2) cosd(afi2) di2; 
     0 0 0 1];
 
% Ti(2-3)
di3=0; ai3=27.51; afi3=0;

Ti23=[cos(qi3) -sin(qi3)*cosd(afi3) sin(qi3)*sind(afi3) ai3*cos(qi3); 
     sin(qi3) cos(qi3)*cosd(afi3) -cos(qi3)*sind(afi3) ai3*sin(qi3); 
     0 sind(afi3) cosd(afi3) di3; 
     0 0 0 1];
 
% Ti(3-4)
di4=0; ai4=17.67; afi4=0;

Ti34=[cos(qi4) -sin(qi4)*cosd(afi4) sin(qi4)*sind(afi4) ai4*cos(qi4); 
     sin(qi4) cos(qi4)*cosd(afi4) -cos(qi4)*sind(afi4) ai4*sin(qi4); 
     0 sind(afi4) cosd(afi4) di4; 
     0 0 0 1];
 
% Ti(4-5)
di5=0; ai5=11.33; afi5=0;

Ti45=[cos(qi5) -sin(qi5)*cosd(afi5) sin(qi5)*sind(afi5) ai5*cos(qi5); 
     sin(qi5) cos(qi5)*cosd(afi5) -cos(qi5)*sind(afi5) ai5*sin(qi5); 
     0 sind(afi5) cosd(afi5) di5; 
     0 0 0 1];
 
% Ti(-1-0)
uix=21.91; uiy=0; uiz=-9.90;

Ti010=[0.9582 0 0.2860 uix; 0 1 0 uiy; -0.2869 0 0.9582 uiz; 0 0 0 1];

%MULTIPLICACION
indice_t=Ti010*Ti01*Ti12*Ti23*Ti34*Ti45