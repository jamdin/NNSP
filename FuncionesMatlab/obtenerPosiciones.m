function datos=obtenerPosiciones(liga)

[ptas,pathAG]=encontrarPaths;

switch liga
        case 'Espana'
            load datosEsp0506_1213_puntos.mat
            path=ptas{1};
            Equipos=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            prefijo='SP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosEsp0506_1213_puntos.mat';
            tp=31;
            ppt=38;

        case 'Inglaterra'
            load datosIng0506_1213_puntos.mat
            path=ptas{2};
            Equipos=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            prefijo='EP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosIng0506_1213_puntos.mat';
            tp=31;
            ppt=38;
            
        case 'Alemania'
            load datosAle0506_1213_puntos.mat
            path=ptas{3};
            Equipos=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            prefijo='DP';
            temp='0607%0708%0809%0910%1011%1112%1213';
            dir='datosAle0506_1213_puntos.mat';
            tp=28;
            ppt=34;
            
        case 'Italia'
            load datosIta0506_1213_puntos.mat
            path=ptas{4};
            Equipos=textread([ptas{4} '\' 'AllTeams.txt'],'%s');
            prefijo='IP';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            dir='datosIta0506_1213_puntos.mat';
            tp=31;
            ppt=38;
            
        case 'Francia'
            load datosFra0506_1213_puntos.mat
            path=ptas{5};
            Equipos=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            prefijo='FP';
            temp='0708%0809%0910%1011%1112%1213';
            dir='datosFra0506_1213_puntos.mat';
            tp=31;
            ppt=38;
end

r=regexp(temp,'%','split');
dat2=cell(size(datos));
Ej=[];

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

       fila=find(strcmp(datosequipo(:,1),part));
       puntosjor=datosequipo(fila:(fila+totalPartidos-1),21)';
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

           fila=find(strcmp(datosequipo(:,1),part));
           pos=a(j,:)';
           dat2(fila:(fila+totalPartidos-1),:,equipo)=[datosequipo(fila:(fila+totalPartidos-1),1:21),num2cell(pos)];
           
       end
       
end

datos=dat2;
end
