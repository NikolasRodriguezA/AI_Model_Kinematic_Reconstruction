import numpy as np
import dh as fk
import roboticstoolbox as rtb
import math
from spatialmath import *

pi = math.pi

j = fk.dh_par(90, 60, -60)
Tm = fk.dh_kine(j)
ee = fk.el_xyzpos(Tm)
p0, p1, p2, p3, p4, p5 = fk.el_pos2base(Tm)
fk.fk_draw2(ee)

# %%%%%%%%%%% Dedo Indice - DH %%%%%%%%%%%%%%%%%%%%%%

I1 = rtb.DHLink(d=0, a=46.53, alpha=-pi/2, sigma=0)
I1.isrevolute
I2 = rtb.DHLink(d=0, a=0, alpha=pi/2, sigma=0)
I2.isrevolute
I3 = rtb.DHLink(d=0, a=27.51, alpha=0, sigma=0)
I3.isrevolute
I4 = rtb.DHLink(d=0, a=17.67, alpha=0, sigma=0)
I4.isrevolute
I5 = rtb.DHLink(d=0, a=11.33, alpha=0, sigma=0)
I5.isrevolute

indice = rtb.DHRobot([I1, I2, I3, I4, I5])
indice.base = np.array([[0.9582, 0, 0.2860, 21.91],
                        [0, 1, 0, 0],
                        [-0.2869, 0, 0.9582, -9.90],
                        [0, 0, 0, 1]])
indice.n


# %%%%%%%%%%% Dedo Medio - DH %%%%%%%%%%%%%%%%%%%%%%

M1 = rtb.DHLink(d=0, a=45.06, alpha=-pi/2, sigma=0)
M1.isrevolute
M2 = rtb.DHLink(d=0, a=0, alpha=pi/2, sigma=0)
M2.isrevolute
M3 = rtb.DHLink(d=0, a=30.81, alpha=0, sigma=0)
M3.isrevolute
M4 = rtb.DHLink(d=0, a=21.22, alpha=0, sigma=0)
M4.isrevolute
M5 = rtb.DHLink(d=0, a=12.65, alpha=0, sigma=0)
M5.isrevolute

medio = rtb.DHRobot([M1, M2, M3, M4, M5])
medio.base = np.array([[0.9976, 0, 0.0699, 24.38],
                        [0, 1, 0, 0],
                        [-0.0699, 0, 0.9976, -2.32],
                        [0, 0, 0, 1]])

# %%%%%%%%%%% Dedo Anular - DH %%%%%%%%%%%%%%%%%%%%%%

A1 = rtb.DHLink(d=0, a=40.21, alpha=-pi/2, sigma=0)
A1.isrevolute
A2 = rtb.DHLink(d=0, a=0, alpha=pi/2, sigma=0)
A2.isrevolute
A3 = rtb.DHLink(d=0, a=28.99, alpha=0, sigma=0)
A3.isrevolute
A4 = rtb.DHLink(d=0, a=19.83, alpha=0, sigma=0)
A4.isrevolute
A5 = rtb.DHLink(d=0, a=13.03, alpha=0, sigma=0)
A5.isrevolute

anular = rtb.DHRobot([A1, A2, A3, A4, A5])
anular.base = np.array([[0.9950, 0, -0.0998, 23.55],
                        [0, 1, 0, 0],
                        [0.0998, 0, 0.9950, 5.45],
                        [0, 0, 0, 1]])

# %%%%%%%%%%% Dedo Meñique - DH %%%%%%%%%%%%%%%%%%%%%%
a = rtb.DHLink
ME1 = rtb.DHLink(d=0, a=37.66, alpha=-pi/2, sigma=0)
ME1.isrevolute
ME2 = rtb.DHLink(d=0, a=0, alpha=pi/2, sigma=0)
ME2.isrevolute
ME3 = rtb.DHLink(d=0, a=21.58, alpha=0, sigma=0)
ME3.isrevolute
ME4 = rtb.DHLink(d=0, a=13.84, alpha=0, sigma=0)
ME4.isrevolute
ME5 = rtb.DHLink(d=0, a=10.96, alpha=0, sigma=0)
ME5.isrevolute

menique = rtb.DHRobot([ME1, ME2, A3, ME4, ME5])
menique.base = np.array([[0.9523, 0, -0.3051, 21.91],
                        [0, 1, 0, 0],
                        [0.3051, 0, 0.9523, 11.69],
                        [0, 0, 0, 1]])

# %%%%%%%%%%% Dedo Anular - DH %%%%%%%%%%%%%%%%%%%%%%

P1 = rtb.DHLink(d=0, a=0, alpha=pi/2, sigma=0)
P1.isrevolute
P2 = rtb.DHLink(d=0, a=30.84, alpha=0, sigma=0)
P2.isrevolute
P3 = rtb.DHLink(d=0, a=20.93, alpha=0, sigma=0)
P3.isrevolute
P4 = rtb.DHLink(d=0, a=15.19, alpha=0, sigma=0)
P4.isrevolute


pulgar = rtb.DHRobot([P1, P2, P3, P4])
pulgar.base = np.array([[0.5817, 0, 0.8134, 16.34],
                        [0, 1, 0, 0],
                        [-0.8134, 0, 0.5817, -19.14],
                        [0, 0, 0, 1]])

# %%%%%%%%%%% Calculo de cinemáticas directas  %%%%%%%%%%%%%%%%%%%%%%

#ndice
qi = [0,0,-0.5,-0.5,-0.5]

#Medio
qm = [0,0,-0.4,-0.4,-0.4]

#Anular
qa = [0,0,0,0,0]

#Meñique
qe = [0,0,0,0,0]

#Pulgar
qp = [0,0,0,0]

Mindice=indice.fkine(qi)
Mmedio=medio.fkine(qm);
Manular=anular.fkine(qa);
Mmenique=menique.fkine(qe);
Mpulgar=pulgar.fkine(qp);

# %%
T = SE3(101.94, 0, 37.14) * SE3.OA([0,0,1], [1,0,0])
# %%
sol = indice.ikine_min(T)


def xyz_2_deg(pos):
    
    Ti = SE3(pos[0]) * SE3.OA([0,0,1], [1,0,0])
    Tm = SE3(pos[1]) * SE3.OA([0,0,1], [1,0,0])
    Ta = SE3(pos[2]) * SE3.OA([0,0,1], [1,0,0])
    Tme = SE3(pos[3]) * SE3.OA([0,0,1], [1,0,0])
    Tp = SE3(pos[4]) * SE3.OA([0,0,1], [1,0,0])
    
    deg_i = indice.ikine_min(Ti).q
    deg_m = medio.ikine_min(Tm).q
    deg_a = anular.ikine_min(Ta).q
    deg_me = menique.ikine_min(Tme).q
    deg_p = pulgar.ikine_min(Tp).q
    
    return np.vstack((deg_i, deg_m, deg_a, deg_me)), deg_p
    


pos_mediapipe = [[01.94, 0, 37.14],
                 [01.94, 0, 37.14],
                 [01.94, 0, 37.14],
                 [01.94, 0, 37.14],
                 [01.94, 0, 37.14],
                 [01.94, 0, 37.14]]


grados_largos, grados_pulgar = xyz_2_deg(pos_mediapipe)
    
    
