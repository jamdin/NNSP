function a=actualizarDatos(liga)

ptas=encontrarPaths;

switch liga
        case 'Espana'
            load datosEsp0506_1213_puntos.mat
            path=ptas{1};
            Equipos=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            prefijo='SP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosEsp0506_1213_puntos2.mat';
            dirxls='pruebaEsp3.xlsx';
            tp=33;
            ppt=38;

        case 'Inglaterra'
            load datosIng0506_1213_puntos.mat
            path=ptas{2};
            Equipos=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            prefijo='EP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosIng0506_1213_puntos2.mat';
            dirxls='pruebaIng3.xlsx';
            tp=35;
            ppt=38;
            
        case 'Alemania'
            load datosAle0506_1213_puntos.mat
            path=ptas{3};
            Equipos=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            prefijo='DP';
            temp='0607%0708%0809%0910%1011%1112%1213';
            dir='datosAle0506_1213_puntos2.mat';
            dirxls='pruebaAle3.xlsx';
            tp=31;
            ppt=34;
            
        case 'Italia'
            load datosIta0506_1213_puntos.mat
            path=ptas{4};
            Equipos=textread([ptas{4} '\' 'AllTeams.txt'],'%s');
            prefijo='IP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosIta0506_1213_puntos2.mat';
            dirxls='pruebaIta3.xlsx';
            tp=34;
            ppt=38;
            
        case 'Francia'
            load datosFra0506_1213_puntos.mat
            path=ptas{5};
            Equipos=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            prefijo='FP';
            temp='0708%0809%0910%1011%1112%1213';
            dir='datosFra0506_1213_puntos2.mat';
            dirxls='pruebaFra3.xlsx';
            tp=34;
            ppt=38;

end
    
r=regexp(temp,'%','split');
datos=cell(380,23,size(Equipos,1));
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
            datos(aux:(aux+size(Ceq,1)-1),1:22,i)=Ceq;
            aux=aux+size(Ceq,1);
        %aumentar j
            j=j+1;
        end
   
    end
end

dat2=cell(size(datos));
%Inclusion de la posicion en la tabla
for i=1:size(temporadas,2) %for de todas las temporadas empezando por la 0708
      tempo=r(i);
      totalPartidos=ppt;
      
      if i==size(temporadas,2)
         totalPartidos=tp; 
      end
     p=zeros(size(temporadas,1),totalPartidos);
     part=strcat(char(tempo),num2str(1));      

     for j=1:size(temporadas,1)%For de los equipos
         nombreEquipo=temporadas(j,i);
         equipo=strcmp(Equipos(:,1),nombreEquipo);
         datosequipo=datos(:,:,equipo);

       fila=find(strcmp(datosequipo(:,1),char(tempo)));

fila=fila(1);
       puntosjor=datosequipo(fila:(fila+totalPartidos-1),22)';
       if size(puntosjor,2)~=size(cell2mat(puntosjor),1)
           puntosjor(end)=puntosjor(end-1);
       end
       p(j,:)=cell2mat(puntosjor);
    
     end
      [dum,indice]=sort(p,1,'descend');
      a=zeros(size(temporadas,1),totalPartidos);
      for e=1:size(temporadas,1)
          for jor=1:totalPartidos
               a(e,jor)=find(indice(:,jor)==e);
          end
      end
      
       for j=1:size(temporadas,1)%For de los equipos

         nombreEquipo=temporadas(j,i);
         equipo=strcmp(Equipos(:,1),nombreEquipo);
         datosequipo=datos(:,:,equipo);

fila=find(strcmp(datosequipo(:,1),char(tempo)));
fila=fila(1);
pos=a(j,:)';
           dat2(fila:(fila+totalPartidos-1),:,equipo)=[datosequipo(fila:(fila+totalPartidos-1),1:22),num2cell(pos)];
           
       end
       
end

datos=dat2;

save(dir,'datos','temporadas');
a=1;
cpf={'Temporada','Jornada', 'Rival', 'H/A', 'HG', 'AG', 'FTR', 'HS', 'AS', 'HST', 'AST', 'HF', 'AG', 'HC', 'AC', 'HY', 'AY', 'HR', 'AR', 'HTHG', 'HTAG', 'Puntos', 'Posicion'};
for i=1:size(Equipos,1)
xlswrite(dirxls,[cpf;datos(:,:,i)],char(Equipos(i,1)));
end

end