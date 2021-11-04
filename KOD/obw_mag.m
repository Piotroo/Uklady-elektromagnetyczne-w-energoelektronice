%%funkcja zawierająca równania róźniczkowe układu
function [yp]=obw_mag(t,y)
% yp=y;
% zp=800; zw=300; l=0.25; S=4.5e-4; R1=2; R2=100;
% Lr1=0.001; Lr2=0.002; a=100;


a = 100;        % wspolczynnik  alfa potrzebny w pierwszych trzech rownaniach 
Zp = 1000;      % ilosc zwoi strony pierwotnej trafo 
Zw = 400;       % ilosc zwoi strony wtornej trafo 
Zd = 500;       % ilosc zwoi dlawika 
lt = 0.25;      % dlugosc trafo 
ld = 0.2;       % dlugosc dlawika 
lpd = 0.0005;   % szczelina powietrzna dlawika
St=4e-4;        % pole przekroju poprzecznego trafo 
Sd=3.5e-4;      % pole przekroju poprzecznego dlawika 
Ls = 0.001;     % indukcuyjnosc cewki S
Rs = 0.5;       % rezystancja rezystora S
Rp = 6;         % rezystancja rezystora P
Lrp = 0.02;     % indukcyjnosc cewki RP
Lrw = 0.003;    % indukcyjnosc cewki RW
Rw = 2.4;       % rezystancja rezystora W
Ld = 1e-6;      % indukcyjnosc diody 
Lrd = 0.0015;   % indukjność RD
Rd = 3;         % rezystancja D
Robc = 100;     % rezystancja obciążenia


mi = 4*pi*10^-7;    % przenikalnosc prozni
Rmp = lpd/(mi*Sd);  % Rezystancja magnetyczna dlawika

% A=[-Lr1,0,-zp;0,-Lr2,zw;zp,-zw,-l/S*dHdBf(y(3)/S)];

A = [   0,       1,    -1,   0,     1,   0,     0,          0,               0;
        0,      -1,     0,  -1,     0,   1,     0,          0,               0;
        0,       0,     1,   1,     0,   0,    -1,          0,               0;
     -Ls-Lrp,    0,     0,   0,     0,   0,     0,         -Zp,              0;
        0,     -Lrw,   -Ld,  Ld,    0,   0,     0,          Zw,              0;
        0,       0,     0,  -Ld,    0,  -Ld,  -Lrd,         0,              -Zd;
        0,       0,    -Ld,  Ld,   -Ld,  Ld,    0,          0,               0;
        Zp,     -Zw,    0,   0,     0,   0,     0,  -lt/St*dHdBf(y(8)/St),   0;
        0,       0,     0,   0,     0,   0,     Zd,         0,      -ld/Sd*dHdBf(y(9)/Sd)-Rmp];
    
        
% B=[R1,0,0;0,R2,0;-a*zp,a*zw,0];

B=[ 0      -a       a   0   -a  0       0           0   0;
    0       a       0   a   0  -a       0           0   0;
    0       0      -a  -a   0   0       a           0   0;
    Rs+Rp   0       0   0   0   0       0           0   0;
    0       Rw      0   0   0   0       0           0   0;
    0       0       0   0   0   0       Rd+Robc     0   0;
    0       0       0   0   0   0       0           0   0;
    -a*Zp   a*Zw    0   0   0   0       0           0   0;
    0       0       0   0   0   0       -a*Zd       0   a*Rmp;];

% C=[-e_zr(t);0;a*l*HBf(y(3)/S)];

C=[ 0;
    0;
    0;
    -e_zr(t);
    Ud(y(3))-Ud(y(4));
    Ud(y(6))+Ud(y(4));
    -Ud(y(4))-Ud(y(6))+Ud(y(5))+Ud(y(3));
    a*HBf(y(8)/St)*lt;
    a*HBf(y(9)/Sd)*ld;];

yp=A\(B*y+C);