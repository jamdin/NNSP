function dat=actualizarDatosSQL(liga,temporada)

ptas=encontrarPaths;

switch liga
        case 'Espana'
            path=ptas{1};
            Equipos=textread([ptas{1} '\' 'Equipos' temporada '.txt'],'%s');
            datab='PartidosEspana';
            prefijo='SP';
 
        case 'Inglaterra'
            path=ptas{2};
            Equipos=textread([ptas{2} '\' 'Equipos' temporada '.txt'],'%s');
            datab='PartidosInglaterra';
            prefijo='EP';
            
        case 'Alemania'
            path=ptas{3};
            Equipos=textread([ptas{3} '\' 'Equipos' temporada '.txt'],'%s');
            datab='PartidosAlemania';
            prefijo='DP';
            
        case 'Italia'
            path=ptas{4};
            Equipos=textread([ptas{4} '\' 'Equipos' temporada '.txt'],'%s');
            datab='PartidosItalia';
            prefijo='IP';
            
        case 'Francia'
           path=ptas{5};
            Equipos=textread([ptas{5} '\' 'Equipos' temporada '.txt'],'%s');
            datab='PartidosFrancia';
            prefijo='FP';

end

s=strcat(path,prefijo,temporada,'.xlsx');
s=char(s);
[n,tmp,partidos]=xlsread(s);

puntos=zeros(1,size(Equipos,1));
jj=zeros(size(Equipos,1),38);
%For de los equipos
    for i=1:size(Equipos,1)
       equipo=char(Equipos(i))
       filasxls=encontrarFilas(partidos,equipo);
       [numfilasdb,ptosant]=encontrarFilasSQL(datab,equipo,temporada);
       
       if size(filasxls,1)>numfilasdb
          for fil=(numfilasdb+1):size(filasxls,1) 
              jj(i,fil)=1;
              C=infoTemporadaSQL(equipo,partidos,temporada,fil,filasxls(fil),ptosant);
              C(:,23)=num2cell(0);
              insertarSQL(datab,equipo,C);
          end
       end
          
          puntos(i)=puntosSQL(datab,equipo,temporada);
          
    end

%     [a,ind]=sort(puntos,2,'descend');
%     [a,ind2]=sort(ind,2);
%     for i=1:size(Equipos,1)
%          equipo=char(Equipos(i))
%          posicion=num2str(ind2(i));
%          jeq=jj(i,:);
%          insertarPosicionSQL(datab,equipo,posicion,temporada,jeq);
%     
%     end
%     
    dat=1;
end