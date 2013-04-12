function c = determinarApuestasTodos(nApuesta)

[ptas,pathAG]=encontrarPaths;
s=[pathAG,'JornadaAbril1214.xlsx'];
[n,t,x]=xlsread(s);

equi=x(:,2:3);
ap=load([pathAG,'apuestasTodos1.txt']);
ap=ap/100;

nap=roundn(nApuesta*ap,-3);
c(:,1:2)=equi;

for f=1:size(x,1)
    for i=1:3
        c(f,i+2)={nap(f,i)};
    end
end

end