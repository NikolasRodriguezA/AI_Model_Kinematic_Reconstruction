%%MODELO CINEMÁTICO TEÓRICO DEDO PULGAR
clc
clear all
%Posición
qp1=-0.5; qp2=0; qp3=0.5; qp4=0.3;
% Tp(0-1)
dp1=0; ap1=0; afp1=(90);
Tp01=[cos(qp1) -sin(qp1)*cosd(afp1) sin(qp1)*sind(afp1) ap1*cos(qp1); 
     sin(qp1) cos(qp1)*cosd(afp1) -cos(qp1)*sind(afp1) ap1*sin(qp1); 
     0 sind(afp1) cosd(afp1) dp1; 
     0 0 0 1];
% Tp(1-2)
dp2=0; ap2=30.84; afp2=0;
Tp12=[cos(qp2) -sin(qp2)*cosd(afp2) sin(qp2)*sind(afp2) ap2*cos(qp2); 
     sin(qp2) cos(qp2)*cosd(afp2) -cos(qp2)*sind(afp2) ap2*sin(qp2); 
     0 sind(afp2) cosd(afp2) dp2; 
     0 0 0 1];
 % Tp(2-3)
dp3=0; ap3=20.93; afp3=0;
Tp23=[cos(qp3) -sin(qp3)*cosd(afp3) sin(qp3)*sind(afp3) ap3*cos(qp3); 
     sin(qp3) cos(qp3)*cosd(afp3) -cos(qp3)*sind(afp3) ap3*sin(qp3); 
     0 sind(afp3) cosd(afp3) dp3; 
     0 0 0 1];
 % Tp(3-4)
dp4=0; ap4=15.19; afp4=0;
Tp34=[cos(qp4) -sin(qp4)*cosd(afp4) sin(qp4)*sind(afp4) ap4*cos(qp4); 
     sin(qp4) cos(qp4)*cosd(afp4) -cos(qp4)*sind(afp4) ap4*sin(qp4); 
     0 sind(afp4) cosd(afp4) dp4; 
     0 0 0 1];
 % Tp(-1-0)
upx=16.34; upy=0; upz=-19.14;
Tp010=[0.5817 0 0.8134 upx; 0 1 0 upy; -0.8134 0 0.5817 upz; 0 0 0 1];
%MULTIPLICACION
pulgar_t=Tp010*Tp01*Tp12*Tp23*Tp34