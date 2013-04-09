temp='0506%0607%0708%0809%0910%1011%1112%1213';
r=regexp(temp,'%','split');
temporadas={};

pts=encontrarPaths;
path=pts{1};

for i=1:size(r,2)
s=strcat(path,'Equipos',r(i),'.txt');
s=char(s);
C=textread(s,'%s');
C=sort(C);
temporadas=[temporadas,C];%Todos los equipos de todas las temporadas
end

Equipos=textread([path,'AllTeams.txt'],'%s');
EjAG=[];
load datosPrimeraDiv0506_1213J29.mat
load RedNeuronalSEDIF
c={Theta1;Theta2;ms};

for i=3:size(temporadas,2) %for de todas las temporadas empezando por la 0708
      tempo=r(i)
      totalPartidos=38;
      
      if i==size(temporadas,2)
         totalPartidos=29; 
      end
      
      s=strcat(path,'SP',r(i),'.xlsx');
            s=char(s);
     [n,tmp,x]=xlsread(s);%se usa 
      
    for jornada=1:totalPartidos%For de las jornadas
        
        for j=1:10%for de partidos por jornada
            fila=(j+1+10*(jornada-1));
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
fid = fopen('EjemplosAG.txt', 'wt');
fprintf(fid, [repmat('%g\t', 1, size(EjAG,2)-1) '%g\n'], roundn(EjAG,-4).');
fclose(fid);
