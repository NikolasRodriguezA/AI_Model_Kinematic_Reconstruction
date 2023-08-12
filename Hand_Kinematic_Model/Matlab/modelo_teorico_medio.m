%%MODELO CINEMÁTICO TEÓRICO DEDO MEDIO
clc
clear all
%Posición
qm1=0; qm2=0; qm3=-0.5; qm4=-0.5; qm5=-0.5;
% Tm(0-1)
dm1=0; am1=45.06; afm1=(-90);
Tm01=[cos(qm1) -sin(qm1)*cosd(afm1) sin(qm1)*sind(afm1) am1*cos(qm1); 
     sin(qm1) cos(qm1)*cosd(afm1) -cos(qm1)*sind(afm1) am1*sin(qm1); 
     0 sind(afm1) cosd(afm1) dm1; 
     0 0 0 1];
% Tm(1-2)
dm2=0; am2=0; afm2=90;
Tm12=[cos(qm2) -sin(qm2)*cosd(afm2) sin(qm2)*sind(afm2) am2*cos(qm2); 
     sin(qm2) cos(qm2)*cosd(afm2) -cos(qm2)*sind(afm2) am2*sin(qm2); 
     0 sind(afm2) cosd(afm2) dm2; 
     0 0 0 1]; 
% Tm(2-3)
dm3=0; am3=30.81; afm3=0;
Tm23=[cos(qm3) -sin(qm3)*cosd(afm3) sin(qm3)*sind(afm3) am3*cos(qm3); 
     sin(qm3) cos(qm3)*cosd(afm3) -cos(qm3)*sind(afm3) am3*sin(qm3); 
     0 sind(afm3) cosd(afm3) dm3; 
     0 0 0 1];
 % Tm(3-4)
dm4=0; am4= 21.22; afm4=0;
Tm34=[cos(qm4) -sin(qm4)*cosd(afm4) sin(qm4)*sind(afm4) am4*cos(qm4); 
     sin(qm4) cos(qm4)*cosd(afm4) -cos(qm4)*sind(afm4) am4*sin(qm4); 
     0 sind(afm4) cosd(afm4) dm4; 
     0 0 0 1]; 
 % Tm(4-5)
dm5=0; am5=12.65; afm5=0;
Tm45=[cos(qm5) -sin(qm5)*cosd(afm5) sin(qm5)*sind(afm5) am5*cos(qm5); 
     sin(qm5) cos(qm5)*cosd(afm5) -cos(qm5)*sind(afm5) am5*sin(qm5); 
     0 sind(afm5) cosd(afm5) dm5; 
     0 0 0 1];
 % Tm(-1-0)
umx=24.38; umy=0; umz=-2.32;
Tm010=[0.9976 0 0.0699 umx; 0 1 0 umy; -0.0699 0 0.9976 umz; 0 0 0 1];
%MULTIPLICACION
medio_t=Tm010*Tm01*Tm12*Tm23*Tm34*Tm45