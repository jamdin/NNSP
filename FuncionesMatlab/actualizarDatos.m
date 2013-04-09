function a=actualizarDatos(liga)

ptas=encontrarPaths;

switch liga
        case 'Espana'
            load datosEsp0506_1213.mat
            path=ptas{1};
            Equipos=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            prefijo='SP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';

        case 'Inglaterra'
            load datosIng0506_1213.mat
            path=ptas{2};
            Equipos=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            prefijo='EP';
            temp='0304%0405%0506%0607%0708%0809%0910%1011%1112%1213';

        case 'Alemania'
            load datosAle0506_1213.mat
            path=ptas{3};
            Equipos=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            prefijo='DP';
            temp='0607%0708%0809%0910%1011%1112%1213';

        case 'Italia'
            load datosIta0506_1213.mat
            path=ptas{4};
            Equipos=textread([ptas{4} '\' 'AllTeams.txt'],'%s');
            prefijo='IP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';

        case 'Francia'
            load datosFra0506_1213.mat
            path=ptas{5};
            Equipos=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            prefijo='FP';
            temp='0708%0809%0910%1011%1112%1213';

end
    
r=regexp(temp,'%','split');
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


switch liga
        case 'Espana'
            save ('datosEsp0506_1213.mat','datos','temporadas');
            a=1;

        case 'Inglaterra'
            save ('datosIng0506_1213.mat','datos','temporadas');
            a=1;
            
        case 'Alemania'
            save ('datosAle0506_1213.mat','datos','temporadas');
            a=1;
            
        case 'Italia'
            save ('datosIta0506_1213.mat','datos','temporadas');
            a=1;
            
        case 'Francia'
            save ('datosFra0506_1213.mat','datos','temporadas');
            a=1;
            
end

end