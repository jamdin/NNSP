liga='Francia'

[ptas,pathAG]=encontrarPaths;

switch liga
        case 'Espana'
            load datosEsp0506_1213.mat
            path=ptas{1};
            Equipos=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            prefijo='SP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosEsp0506_1213_puntos.mat';
            tp=31;
            ppt=38;

        case 'Inglaterra'
            load datosIng0506_1213.mat
            path=ptas{2};
            Equipos=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            prefijo='EP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosIng0506_1213_puntos.mat';
            tp=31;
            ppt=38;
            
        case 'Alemania'
            load datosAle0506_1213.mat
            path=ptas{3};
            Equipos=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            prefijo='DP';
            temp='0607%0708%0809%0910%1011%1112%1213';
            dir='datosAle0506_1213_puntos.mat';
            tp=28;
            ppt=34;
            
        case 'Italia'
            load datosIta0506_1213.mat
            path=ptas{4};
            Equipos=textread([ptas{4} '\' 'AllTeams.txt'],'%s');
            prefijo='IP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosIta0506_1213_puntos.mat';
            tp=31;
            ppt=38;
            
        case 'Francia'
            load datosFra0506_1213.mat
            path=ptas{5};
            Equipos=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            prefijo='FP';
            temp='0708%0809%0910%1011%1112%1213';
            dir='datosFra0506_1213_puntos.mat';
            tp=31;
            ppt=38;
end

r=regexp(temp,'%','split');



datos=cell(380,21,size(Equipos,1));
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
            s=strcat(path,prefijo,r(j),'.xlsx');%SP Espana, EP Inglaterra, DP Alemania, IP Italia, FP Francia
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

save (dir,'datos','temporadas');