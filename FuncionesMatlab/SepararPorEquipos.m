temp='0708%0809%0910%1011%1112%1213';
r=regexp(temp,'%','split');
temporadas={};

paths=encontrarPaths;
path=paths{5};%paths{1} Espana
              %paths{2} Inglaterra
              %paths{3} Alemania
              %paths{4} Italia
              %paths{5} Francia

for i=1:size(r,2)
s=strcat(path,'Equipos',r(i),'.txt');
s=char(s);
C=textread(s,'%s');
C=sort(C);
temporadas=[temporadas,C];%Todos los equipos de todas las temporadas
end


Equipos=textread([path,'AllTeams.txt'],'%s');
datos=cell(380,18,size(Equipos,1));
for i=1:size(Equipos,1) %for de todos los equipos
    
    equipo=Equipos(i)
    aux=1;
    j=1;
    while j<=size(r,2) %while de las temporadas
        
        %Revisar si participo en esa temporada
        t=temporadas(:,j);
        b=estaEnArreglo(equipo,t);
        
        if b==0
            j=j+1;
        else
            %abrir archivo de la temporada
            s=strcat(path,'FP',r(j),'.xlsx');%SP Espana, EP Inglaterra, DP Alemania, IP Italia, FP Francia
            s=char(s);
            [n,tmp,x]=xlsread(s);%se usa x
        %buscar partidos de la temporada    
            Ceq=infoTemporada(equipo,x,r(j));
            %Guardar partidos en el archivo
            datos(aux:(aux+size(Ceq,1)-1),:,i)=Ceq;
            aux=aux+size(Ceq,1);
        %aumentar j
            j=j+1;
        end
   
    end
end

save ('datosFra0506_1213.mat','datos','temporadas');