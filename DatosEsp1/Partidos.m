function [D] = Partidos(datos,ventana,numpartido)
%datos del equipo
%ventana: numero de partidos
%numpartido: a partir de cual partido
r=find(strcmp(datos(:,1),numpartido));%encuentra el numero de fila del partido

if r<=ventana
   ventana=r-1; 
end

if r>1
dat=datos((r-ventana):(r-1),:);%Ventana de partidos
D=resultados(dat,ventana);
else
    D=zeros(1,12);
    
end
end