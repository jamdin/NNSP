[ptas,pathAG]=encontrarPaths;

%Espana
s=[ptas{1},'Jornada32Esp.xlsx'];
[n,t,x]=xlsread(s);
pred=load([pathAG,'PartidosJ32Esp.txt']);
ap=load([pathAG,'apuestasEsp32.txt']);
ap=ap/100;
nap=roundn(ap,-3);
a=find(sum(nap>0,2));
pEsp=pred(a,:);
teamsEsp=x(a,1:2);


%Inglaterra
s=[ptas{2},'Jornada32Ing.xlsx'];
[n,t,x]=xlsread(s);
pred=load([pathAG,'PartidosJ32Ing.txt']);
ap=load([pathAG,'apuestasIng32.txt']);
ap=ap/100;
nap=roundn(ap,-3);
a=find(sum(nap>0,2));
pIng=pred(a,:);
teamsIng=x(a,1:2);

%Alemania
s=[ptas{3},'Jornada29Ale.xlsx'];
[n,t,x]=xlsread(s);
pred=load([pathAG,'PartidosJ29Ale.txt']);
ap=load([pathAG,'apuestasAle29.txt']);
ap=ap/100;
nap=roundn(ap,-3);
a=find(sum(nap>0,2));
pAle=pred(a,:);
teamsAle=x(a,1:2);

%Italia
s=[ptas{4},'Jornada32Ita.xlsx'];
[n,t,x]=xlsread(s);
pred=load([pathAG,'PartidosJ32Ita.txt']);
ap=load([pathAG,'apuestasIta32.txt']);
ap=ap/100;
nap=roundn(ap,-3);
a=find(sum(nap>0,2));
pIta=pred(a,:);
teamsIta=x(a,1:2);

%Francia
s=[ptas{5},'Jornada32Fra.xlsx'];
[n,t,x]=xlsread(s);
pred=load([pathAG,'PartidosJ32Fra.txt']);
ap=load([pathAG,'apuestasFra32.txt']);
ap=ap/100;
nap=roundn(ap,-3);
a=find(sum(nap>0,2));
pFra=pred(a,:);
teamsFra=x(a,1:2);

teams=cell(size(teamsEsp,1)+size(teamsIng,1)+size(teamsAle,1)+size(teamsIta,1)+size(teamsFra,1),2);
fila=1;
for i=1:size(teamsEsp,1)
    teams(fila,1:2)=teamsEsp(i,1:2);
    fila=fila+1;
end
for i=1:size(teamsIng,1)
    teams(fila,1:2)=teamsIng(i,1:2);
    fila=fila+1;
end
for i=1:size(teamsAle,1)
    teams(fila,1:2)=teamsAle(i,1:2);
    fila=fila+1;
end
for i=1:size(teamsIta,1)
    teams(fila,1:2)=teamsIta(i,1:2);
    fila=fila+1;
end
for i=1:size(teamsFra,1)
    teams(fila,1:2)=teamsFra(i,1:2);
    fila=fila+1;
end
%Juntar todos
pjuntos=[pEsp;pIng;pAle;pIta;pFra];

 fid = fopen([pathAG,'PartidosJ32Unidos.txt'], 'wt');
fprintf(fid, [repmat('%g\t', 1, size(pjuntos,2)-1) '%g\n'], roundn(pjuntos,-4).');
fclose(fid);