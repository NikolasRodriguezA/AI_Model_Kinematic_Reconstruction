%%MODELO CINEMÁTICO TEÓRICO DEDO MEÑIQUE
clc
clear all
%Posición
qe1=0; qe2=0; qe3=-0.5; qe4=-0.5; qe5=-0.5;
% Te(0-1)
de1=0; ae1=37.66; afe1=(-90);
Te01=[cos(qe1) -sin(qe1)*cosd(afe1) sin(qe1)*sind(afe1) ae1*cos(qe1); 
     sin(qe1) cos(qe1)*cosd(afe1) -cos(qe1)*sind(afe1) ae1*sin(qe1); 
     0 sind(afe1) cosd(afe1) de1; 
     0 0 0 1];
% Te(1-2)
de2=0; ae2=0; afe2=90;
Te12=[cos(qe2) -sin(qe2)*cosd(afe2) sin(qe2)*sind(afe2) ae2*cos(qe2); 
     sin(qe2) cos(qe2)*cosd(afe2) -cos(qe2)*sind(afe2) ae2*sin(qe2); 
     0 sind(afe2) cosd(afe2) de2; 
     0 0 0 1]; 
% Te(2-3)
de3=0; ae3=21.58; afe3=0;
Te23=[cos(qe3) -sin(qe3)*cosd(afe3) sin(qe3)*sind(afe3) ae3*cos(qe3); 
     sin(qe3) cos(qe3)*cosd(afe3) -cos(qe3)*sind(afe3) ae3*sin(qe3); 
     0 sind(afe3) cosd(afe3) de3; 
     0 0 0 1]; 
 % Te(3-4)
de4=0; ae4= 13.84; afe4=0;
Te34=[cos(qe4) -sin(qe4)*cosd(afe4) sin(qe4)*sind(afe4) ae4*cos(qe4); 
     sin(qe4) cos(qe4)*cosd(afe4) -cos(qe4)*sind(afe4) ae4*sin(qe4); 
     0 sind(afe4) cosd(afe4) de4; 
     0 0 0 1];
 % Te(4-5)
de5=0; ae5=10.96; afe5=0;
Te45=[cos(qe5) -sin(qe5)*cosd(afe5) sin(qe5)*sind(afe5) ae5*cos(qe5); 
     sin(qe5) cos(qe5)*cosd(afe5) -cos(qe5)*sind(afe5) ae5*sin(qe5); 
     0 sind(afe5) cosd(afe5) de5; 
     0 0 0 1];
 % Te(-1-0)
uex=21.91; uey=0; uez=11.69;
Te010=[0.9523 0 -0.3051 uex; 0 1 0 uey; 0.3051 0 0.9523 uez; 0 0 0 1];
%MULTIPLICACION
menique_t=Te010*Te01*Te12*Te23*Te34*Te45