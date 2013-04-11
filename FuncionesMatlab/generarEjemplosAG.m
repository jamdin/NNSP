temp='0708%0809%0910%1011%1112%1213';
r=regexp(temp,'%','split');
temporadas={};
[pts,pathAG]=encontrarPaths;
path=pts{5};%paths{1} Espana
            %paths{2} Inglaterra
            %paths{3} Alemania
            %paths{4} Italia
            %paths{5} Francia

for i=1:size(r,2)
s=strcat(path,'Equipos',r(i),'.txt');
s=char(s);
C=textread(s,'%s');
C=sort(C);
temporadas1=[temporadas,C];%Todos los equipos de todas las temporadas
end

Equipos=textread([path,'AllTeams.txt'],'%s');
EjAG=[];
load datosFra0506_1213.mat
load RedNeuronalSEDIF
c={Theta1;Theta2;ms};
size(temporadas)
for i=3:size(temporadas,2) %for de todas las temporadas empezando por la 0708
      tempo=r(i)
      totalPartidos=38;
      NumPartidos=10;
      if i==size(temporadas,2)
         totalPartidos=31; 
      end
      
      s=strcat(path,'FP',r(i),'.xlsx');
            s=char(s);
     [n,tmp,x]=xlsread(s);%se usa 
      
    for jornada=1:totalPartidos%For de las jornadas

        for j=1:NumPartidos%for de partidos por jornada
            fila=(j+1+NumPartidos*(jornada-1))
        nombreLocal=eliminarEspacios(char(x(fila,3)));
        nombreVis=eliminarEspacios(char(x(fila,4)));
        hda=x(fila,7);
        bet365=cell2mat(x(fila,23:25));
    if char(hda)=='H'
        resultado=1;
    elseif char(hda)=='D'
        resultado=2;
    else
        resultado=3;
    end
    
        part=strcat(char(tempo),num2str(jornada));

        
        [p,h]=predecirPartido(c,datos,Equipos,nombreLocal,nombreVis,part);
        E=[h,bet365,resultado];
        EjAG=[EjAG;E];
        
        
        end
    end
end

save ('EjemplosJ29AG.mat','EjAG');
fid = fopen([pathAG,'EjemplosAGFra.txt'], 'wt');
fprintf(fid, [repmat('%g\t', 1, size(EjAG,2)-1) '%g\n'], roundn(EjAG,-4).');
fclose(fid);
