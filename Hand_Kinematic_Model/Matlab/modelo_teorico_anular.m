%%MODELO CINEMÁTICO TEÓRICO DEDO ANULAR
clc
clear all
%Posición
qa1=0; qa2=0; qa3=-0.5; qa4=-0.5; qa5=-0.5;
% Ta(0-1)
da1=0; aa1=40.21; afa1=(-90);
Ta01=[cos(qa1) -sin(qa1)*cosd(afa1) sin(qa1)*sind(afa1) aa1*cos(qa1); 
     sin(qa1) cos(qa1)*cosd(afa1) -cos(qa1)*sind(afa1) aa1*sin(qa1); 
     0 sind(afa1) cosd(afa1) da1; 
     0 0 0 1];
% Ta(1-2)
da2=0; aa2=0; afa2=90;
Ta12=[cos(qa2) -sin(qa2)*cosd(afa2) sin(qa2)*sind(afa2) aa2*cos(qa2); 
     sin(qa2) cos(qa2)*cosd(afa2) -cos(qa2)*sind(afa2) aa2*sin(qa2); 
     0 sind(afa2) cosd(afa2) da2; 
     0 0 0 1]; 
% Ta(2-3)
da3=0; aa3=28.99; afa3=0;
Ta23=[cos(qa3) -sin(qa3)*cosd(afa3) sin(qa3)*sind(afa3) aa3*cos(qa3); 
     sin(qa3) cos(qa3)*cosd(afa3) -cos(qa3)*sind(afa3) aa3*sin(qa3); 
     0 sind(afa3) cosd(afa3) da3; 
     0 0 0 1];
 % Ta(3-4)
da4=0; aa4= 19.83; afa4=0;
Ta34=[cos(qa4) -sin(qa4)*cosd(afa4) sin(qa4)*sind(afa4) aa4*cos(qa4); 
     sin(qa4) cos(qa4)*cosd(afa4) -cos(qa4)*sind(afa4) aa4*sin(qa4); 
     0 sind(afa4) cosd(afa4) da4; 
     0 0 0 1];
 % Ta(4-5)
da5=0; aa5=13.03; afa5=0;
Ta45=[cos(qa5) -sin(qa5)*cosd(afa5) sin(qa5)*sind(afa5) aa5*cos(qa5); 
     sin(qa5) cos(qa5)*cosd(afa5) -cos(qa5)*sind(afa5) aa5*sin(qa5); 
     0 sind(afa5) cosd(afa5) da5; 
     0 0 0 1];
 % Ta(-1-0)
uax=23.55; uay=0; uaz=5.45;
Ta010=[0.9950 0 -0.0998 uax; 0 1 0 uay; 0.0998 0 0.9950 uaz; 0 0 0 1];
%MULTIPLICACION
anular_t=Ta010*Ta01*Ta12*Ta23*Ta34*Ta45