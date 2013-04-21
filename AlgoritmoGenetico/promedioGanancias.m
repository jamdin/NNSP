clc
gSP=load('gananciasEspS.txt');
gEP=load('gananciasIngS.txt');
gDP=load('gananciasAleS.txt');
gIP=load('gananciasItaS.txt');
gFP=load('gananciasFraS.txt');
%Columna Ganancia neta
gSP=gSP(:,2);
gEP=gEP(:,2);
gDP=gDP(:,2);
gIP=gIP(:,2);
gFP=gFP(:,2);

%Calcular Promedio
mS=mean(gSP);
mE=mean(gEP);
mD=mean(gDP);
mI=mean(gIP);
mF=mean(gFP);

%Calcular perdidas

nS=sum(gSP<0);
nE=sum(gEP<0);
nD=sum(gDP<0);
nI=sum(gIP<0);
nF=sum(gFP<0);

%Calcular Ganancias

pS=sum(gSP>0);
pE=sum(gEP>0);
pD=sum(gDP>0);
pI=sum(gIP>0);
pF=sum(gFP>0);

%Calcular Porcentaje de Ganancias

porS=pS/(pS+nS);
porE=pE/(pE+nE);
porD=pD/(pD+nD);
porI=pI/(pI+nI);
porF=pF/(pF+nF);

%%%%%%%%%%
m=[mS nS pS porS (1-porS);mE nE pE porE (1-porE);mD nD pD porD (1-porD);mI nI pI porI (1-porI);mF nF pF porF (1-porF)];
porT=sum(m(:,3))/(sum(sum(m(:,2:3))));
u=[mean(m(:,1)),sum(m(:,2:3)),porT, (1-porT)];
mm=[m;u]
