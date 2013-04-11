gSP=load('gananciasEspana.txt');
gEP=load('gananciasIng.txt');
gDP=load('gananciasAle.txt');
gIP=load('gananciasIta.txt');
gFP=load('gananciasFra.txt');

mS=mean(gSP);
mE=mean(gEP);
mD=mean(gDP);
mI=mean(gIP);
mF=mean(gFP);

m=[mS;mE;mD;mI;mF];

mm=[m;mean(m)]/100
