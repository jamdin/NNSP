[l,v,a1,a2,a3]=textread('predTodosUnidos1213MayS1_Nombre.txt','%s%s%f%f%f');

equipos=[l,v];
apuestas=[a1,a2,a3];
c=[equipos,num2cell(apuestas)];
equipos=sortrows(c);
eqant=equipos{1,1};
par=1;
p=zeros(size(equipos,1),1);
p(1)=1;
for i=2:size(equipos,1)
if strcmp(eqant,equipos{i,1})
p(i)=par;
else
eqant=equipos{i,1};
par=par+1;
p(i)=par;
end
end

prom=cell(par,5);

for i=1:par
    f=find(p==i);
    aux=equipos(f,:);
    prom(i,1:2)=aux(1,1:2);
    m=cell2mat(aux(:,3:5));
    prom(i,3:5)=num2cell(mean(m,1));
end
s=sum(sum(cell2mat(prom(:,3:5))));
rn=round(100*cell2mat(prom(:,3:5))/s);
sf=sum(rn,2);
f=find(sf~=0);
prom(:,3:5)=num2cell(rn);
prom=prom(f,:)




