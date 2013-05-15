function [D,ptsacum,pos] = PartidosFuzzy(datos,ventana,numpartido,ymin,ymax)
%datos del equipo
%ventana: numero de partidos
%numpartido: a partir de cual partido

r=find(strcmp(datos(:,1),numpartido));%encuentra el numero de fila del partido

if r<=ventana
   ventana=r; 
end

if r>=1
dat=datos((r-ventana+1):r,:);%Ventana de partidos
[D]=resultadosFuzzy(dat,ventana,ymin,ymax);
else
    D=zeros(1,5);
end
end