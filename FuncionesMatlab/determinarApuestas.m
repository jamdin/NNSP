function c=determinarApuestas(liga, nApuesta,archivoPartidos,archivoApuestas)
% %Liga
% 1 Espana
% 2 Inglaterra
% 3 Alemania
% 4 Italia
% 5 Francia

c=cell(10,5);

[ptas,pathAG]=encontrarPaths;
s=[ptas{liga},archivoPartidos];
[n,t,x]=xlsread(s);

eq=x(:,1:2);

ap=load([pathAG,archivoApuestas]);
ap=ap/100;

nap=roundn(nApuesta*ap,-3);
c(:,1:2)=eq;

for f=1:10
    for i=1:3
        c(f,i+2)={nap(f,i)};
    end
end
end