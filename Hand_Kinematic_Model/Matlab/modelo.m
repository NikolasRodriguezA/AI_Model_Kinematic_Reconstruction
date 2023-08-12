%% MODELO CAD-CINEMATICA
clear all
clc

%%%%%%%%%%DEDO INDICE%%%%%%%%%%

I1 = Link('d', 0, 'a', 46.53, 'alpha', -pi/2);
I1.isrevolute;

I2 = Link('d', 0, 'a', 0, 'alpha', pi/2);
I2.isrevolute;

I3 = Link('d', 0, 'a', 27.51, 'alpha',0);
I3.isrevolute;

I4 = Link('d', 0, 'a', 17.67, 'alpha',0);
I4.isrevolute;

I5 = Link('d', 0, 'a', 11.33, 'alpha',0);
I5.isrevolute

indice=SerialLink([I1 I2 I3 I4 I5],'name','indice')
indice.base=[0.9582 0 0.2860 21.91; 0 1 0 0; -0.2869 0 0.9582 -9.90; 0 0 0 1];
indice.n;

indice.fkine([0 0 0 0 0])

%%%%%%%%%%DEDO MEDIO%%%%%%%%%%

M1 = Link('d', 0, 'a', 45.06, 'alpha', -pi/2);
M1.isrevolute;

M2 = Link('d', 0, 'a', 0, 'alpha', pi/2),
M2.isrevolute;

M3 = Link('d', 0, 'a', 30.81, 'alpha',0);
M3.isrevolute;

M4 = Link('d', 0, 'a', 21.22, 'alpha',0);
M4.isrevolute;

M5 = Link('d', 0, 'a', 12.65, 'alpha',0);
M5.isrevolute;

medio=SerialLink([M1 M2 M3 M4 M5],'name','medio')
medio.base=[0.9976 0 0.0699 24.38; 0 1 0 0; -0.0699 0 0.9976 -2.32; 0 0 0 1];
medio.n;

medio.fkine([0 0 0 0 0])

%%%%%%%%%%DEDO ANULAR%%%%%%%%%%

A1 = Link('d', 0, 'a', 40.21, 'alpha', -pi/2);
A1.isrevolute;

A2 = Link('d', 0, 'a', 0, 'alpha', pi/2),
A2.isrevolute;

A3 = Link('d', 0, 'a', 28.99, 'alpha',0);
A3.isrevolute;

A4 = Link('d', 0, 'a', 19.83, 'alpha',0);
A4.isrevolute;

A5 = Link('d', 0, 'a', 13.03, 'alpha',0);
A5.isrevolute;

anular=SerialLink([A1 A2 A3 A4 A5],'name','anular')
anular.base=[0.9950 0 -0.0998 23.55; 0 1 0 0; 0.0998 0 0.9950 5.45; 0 0 0 1];
anular.n;

anular.fkine([0 0 0 0 0])

%%%%%%%%%%DEDO MEÑIQUE%%%%%%%%%%

ME1 = Link('d', 0, 'a', 37.66, 'alpha', -pi/2);
ME1.isrevolute;

ME2 = Link('d', 0, 'a', 0, 'alpha', pi/2),
ME2.isrevolute;

ME3 = Link('d', 0, 'a', 21.58, 'alpha',0);
ME3.isrevolute;

ME4 = Link('d', 0, 'a', 13.84, 'alpha',0);
ME4.isrevolute;

ME5 = Link('d', 0, 'a', 10.96, 'alpha',0);
ME5.isrevolute;

menique=SerialLink([ME1 ME2 ME3 ME4 ME5],'name','menique')
menique.base=[0.9523 0 -0.3051 21.91; 0 1 0 0; 0.3051 0 0.9523 11.69; 0 0 0 1];
menique.n;

menique.fkine([0 0 0 0 0])

%%%%%%%%%%DEDO PULGAR%%%%%%%%%%

P1 = Link('d', 0, 'a', 0, 'alpha', pi/2);
P1.isrevolute;

P2 = Link('d', 0, 'a', 30.84, 'alpha',0);
P2.isrevolute;

P3 = Link('d', 0, 'a', 20.93, 'alpha',0);
P3.isrevolute;

P4 = Link('d', 0, 'a', 15.19, 'alpha',0);
P4.isrevolute

pulgar=SerialLink([P1 P2 P3 P4],'name','pulgar')
pulgar.base=[0.5817 0 0.8134 16.34; 0 1 0 0; -0.8134 0 0.5817 -19.14; 0 0 0 1];
pulgar.n;

pulgar.fkine([0 0 0 0])

%%%%%%%%%%VECTORES DE POSICIONAMIENTO DE BASE%%%%%%%%%%

%Indice%
pi0 = [0 0 0]; 
pi1 = [21.91 0 -9.90]; 

%Medio%
pm0 = [0 0 0]; 
pm1 = [24.38 0 -2.32]; 

%Anular%
pa0 = [0 0 0]; 
pa1 = [24.17 0 5.45]; 

%Meñique%
pme0 = [0 0 0]; 
pme1 = [21.91 0 11.69]; 

%Pulgar%
pp0 = [0 0 0]; 
pp1 = [16.34 0 -19.14]; 

%%%%%%%%%%ROTACIÓN DE LAS JUNTURAS%%%%%%%%%%

%Indice%
qi1=0;
qi2=0;
qi3=-0.5;
qi4=-0.5;
qi5=-0.5;

%Medio%
qm1=0;
qm2=0;
qm3=-0.4;
qm4=-0.4;
qm5=-0.4;

%Anular%
qa1=0;
qa2=0;
qa3=0;
qa4=0;
qa5=0;

%Meñique%
qe1=0;
qe2=0;
qe3=0;
qe4=0;
qe5=0;

%Pulgar%
qp1=0;
qp2=0;
qp3=0;
qp4=0;

%%%%%PLOTS%%%%%

indice.plot([qi1 qi2 qi3 qi4 qi5],'notiles','nobase','noshadow','ortho','noname','jointdiam',3)
hold on
medio.plot([qm1 qm2 qm3 qm4 qm5],'notiles','nobase','noshadow','noname','jointdiam',3)
hold on
anular.plot([qa1 qa2 qa3 qa4 qa5],'notiles','nobase','noshadow','noname','jointdiam',3)
hold on
menique.plot([qe1 qe2 qe3 qe4 qe5],'notiles','nobase','noshadow','noname','jointdiam',3)
hold on
pulgar.plot([qp1 qp2 qp3 qp4],'notiles','nobase','noshadow','noname','jointdiam',3)


%%%%%%%%%%SOLICITUD DE MATRIZ%%%%%%%%%

Mindice=indice.fkine([qi1 qi2 qi3 qi4 qi5])

Mmedio=medio.fkine([qm1 qm2 qm3 qm4 qm5]);

Manular=anular.fkine([qa1 qa2 qa3 qa4 qa5]);

Mmenique=menique.fkine([qe1 qe2 qe3 qe4 qe5]);

Mpulgar=pulgar.fkine([qp1 qp2 qp3 qp4]);


DH_indice = [indice.alpha' indice.a' zeros(5,1) indice.d' ones(5,1)];
[dof,m]=size(DH_indice); 
q_ini = zeros(1,dof);

for i=dof:-1:1

    sigma = DH_indice(i,5);    %sigma=0 (rotacional), sigma=1 (prism?tico)

    n=Mindice.a;
    o=Mindice.o;
    a=Mindice.a;
    p=Mindice.t;
    
    if sigma==0  % Rotacional
        Jac(1,i)=-n(1)*p(2)+n(2)*p(1);
        Jac(2,i)=-o(1)*p(2)+o(2)*p(1);
        Jac(3,i)=-a(1)*p(2)+a(2)*p(1);
        Jac(4,i)=n(3);
        Jac(5,i)=o(3);
        Jac(6,i)=a(3);
    else %Prismatico
        Jac(1,i)=n(3);
        Jac(2,i)=o(3);
        Jac(3,i)=a(3);
        Jac(4,i)=0;
        Jac(5,i)=0;
        Jac(6,i)=0;        
    end
    
end


J = Jac
q = pinv(J(1:3,:))*Mindice.t+q_ini;



