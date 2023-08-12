%%Multiplicación matrices homogeneas mano humana
clc
clear all
%%Dedos Indice, Medio, Anular, Meñique

% T(0-1)
syms qic Lime
Q1=qic;
d1=0;
a1=Lime;
af1=(-90);

T01=[cos(Q1) -sin(Q1)*cosd(af1) sin(Q1)*sind(af1) a1*cos(Q1); 
     sin(Q1) cos(Q1)*cosd(af1) -cos(Q1)*sind(af1) a1*sin(Q1); 
     0 sind(af1) cosd(af1) d1; 
     0 0 0 1];


% T(1-2)
syms qima
Q2=qima;
d2=0;
a2=0;
af2=90;

T12=[cos(Q2) -sin(Q2)*cosd(af2) sin(Q2)*sind(af2) a2*cos(Q2); 
     sin(Q2) cos(Q2)*cosd(af2) -cos(Q2)*sind(af2) a2*sin(Q2); 
     0 sind(af2) cosd(af2) d2; 
     0 0 0 1];
 
% T(2-3)
syms qimf Lip
Q3=qimf;
d3=0;
a3=Lip;
af3=0;

T23=[cos(Q3) -sin(Q3)*cosd(af3) sin(Q3)*sind(af3) a3*cos(Q3); 
     sin(Q3) cos(Q3)*cosd(af3) -cos(Q3)*sind(af3) a3*sin(Q3); 
     0 sind(af3) cosd(af3) d3; 
     0 0 0 1];
 
% T(3-4)
syms qip Limi
Q4=qip;
d4=0;
a4=Limi;
af4=0;

T34=[cos(Q4) -sin(Q4)*cosd(af4) sin(Q4)*sind(af4) a4*cos(Q4); 
     sin(Q4) cos(Q4)*cosd(af4) -cos(Q4)*sind(af4) a4*sin(Q4); 
     0 sind(af4) cosd(af4) d4; 
     0 0 0 1];
 
% T(4-5)
syms qid Lid
Q5=qid;
d5=0;
a5=Lid;
af5=0;

T45=[cos(Q5) -sin(Q5)*cosd(af5) sin(Q5)*sind(af5) a5*cos(Q5); 
     sin(Q5) cos(Q5)*cosd(af5) -cos(Q5)*sind(af5) a5*sin(Q5); 
     0 sind(af5) cosd(af5) d5; 
     0 0 0 1];
 
 % T(-1-0)
syms uix uiy uiz 
T010=[1 0 0 uix; 0 1 0 uiy; 0 0 1 uiz; 0 0 0 1];

%MULTIPLICACION

Pi=T010*T01*T12*T23*T34*T45


%_______________________________________________________________________________________
%%Dedo pulgar

% Tp(0-1)
syms qpta
Qp1=qpta;
dp1=0;
ap1=0;
afp1=(90);

Tp01=[cos(Qp1) -sin(Qp1)*cosd(afp1) sin(Qp1)*sind(afp1) ap1*cos(Qp1); 
     sin(Qp1) cos(Qp1)*cosd(afp1) -cos(Qp1)*sind(afp1) ap1*sin(Qp1); 
     0 sind(afp1) cosd(afp1) dp1; 
     0 0 0 1];

% Tp(1-2)
syms qptf Ltm
Qp2=qptf;
dp2=0;
ap2=Ltm;
afp2=0;

Tp12=[cos(Qp2) -sin(Qp2)*cosd(afp2) sin(Qp2)*sind(afp2) ap2*cos(Qp2); 
     sin(Qp2) cos(Qp2)*cosd(afp2) -cos(Qp2)*sind(afp2) ap2*sin(Qp2); 
     0 sind(afp2) cosd(afp2) dp2; 
     0 0 0 1];

 % Tp(2-3)
syms qpm Ltp
Qp3=qpm;
dp3=0;
ap3=Ltp;
afp3=0;

Tp23=[cos(Qp3) -sin(Qp3)*cosd(afp3) sin(Qp3)*sind(afp3) ap3*cos(Qp3); 
     sin(Qp3) cos(Qp3)*cosd(afp3) -cos(Qp3)*sind(afp3) ap3*sin(Qp3); 
     0 sind(afp3) cosd(afp3) dp3; 
     0 0 0 1];
 
 % Tp(3-4)
syms qpi Ltd
Qp4=qpi;
dp4=0;
ap4=Ltd;
afp4=0;

Tp34=[cos(Qp4) -sin(Qp4)*cosd(afp4) sin(Qp4)*sind(afp4) ap4*cos(Qp4); 
     sin(Qp4) cos(Qp4)*cosd(afp4) -cos(Qp4)*sind(afp4) ap4*sin(Qp4); 
     0 sind(afp4) cosd(afp4) dp4; 
     0 0 0 1];
 
 % Tp(-1-0)
syms upx upy upz
qup=-90;
Tp010=[1 0 0 upx; 0 cosd(qup) -sind(qup) upy; 0 sind(qup) cosd(qup) upz; 0 0 0 1];

%MULTIPLICACION

Pp=Tp010*Tp01*Tp12*Tp23*Tp34
