function y=predfuzz(x,tabla1,tabla2,b,c,w)

%Prediccion Local
xloc=x(1:5);
bloc=b(:,1);
cloc=c(:,1);
wloc=w(:,1);
yloc=predY(xloc,bloc,cloc,wloc,tabla1);


%Prediccion Visitante
xvis=x(6:10);
bvis=b(:,2);
cvis=c(:,2);
wvis=w(:,2);
yvis=predY(xvis,bvis,cvis,wvis,tabla1);

%Prediccion Local
xuni=[x(11:12),yloc,yvis]
buni=b(:,3);
cuni=c(:,3);
wuni=w(:,3);
y=predY(xuni,buni,cuni,wuni,tabla2);
%y=predYuni(xuni,buni,cuni,wuni,tabla2,bloc,bvis,cloc,cvis);

end