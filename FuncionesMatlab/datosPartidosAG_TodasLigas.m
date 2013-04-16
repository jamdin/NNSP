[ptas,pathAG]=encontrarPaths;
s=[pathAG,'JornadaAbril57.xlsx'];
[n,t,x]=xlsread(s);
load RedNeuronalSEDIF
c={Theta1;Theta2;ms};
pred=zeros(size(x,1),6);

%Contar cuantos partidos hay por liga
l=x(:,1);
l=cell2mat(l);
numS=sum(l=='S');
numE=sum(l=='E');
numD=sum(l=='D');
numI=sum(l=='I');
numF=sum(l=='F');

n=[numS,numE,numD,numI,numF];
i=1;
for liga=1:5%For de las ligas
    liga
    switch liga   %Cargar Datos de cada liga
        case 1
            load datosEsp0506_1213.mat
            teams=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            jornada='121329';
        case 2
            load datosIng0506_1213.mat
            teams=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            jornada='121330';
        case 3
            load datosAle0506_1213.mat
            teams=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            jornada='121327';
        case 4
            load datosIta0506_1213.mat
            teams=textread([ptas{4} '\' 'AllTeams.txt'],'%s');     
            jornada='121330';
        case 5
            load datosFra0506_1213.mat
            teams=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            jornada='121330';
    end
    
    for p=1:n(liga)
        i
        [p,h]=predecirPartido(c,datos,teams,eliminarEspacios(x{i,2}),eliminarEspacios(x{i,3}),jornada);
        ap=x(i,4:6);
        pred(i,:)=[h,cell2mat(ap)]; 
        i=i+1;
    end
  
fid = fopen([pathAG,'PartidosAbril57.txt'], 'wt');
fprintf(fid, [repmat('%g\t', 1, size(pred,2)-1) '%g\n'], roundn(pred,-4).');
fclose(fid);
    
end