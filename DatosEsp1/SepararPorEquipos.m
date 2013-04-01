temp='0506%0607%0708%0809%0910%1011%1112%1213';
r=regexp(temp,'%','split');
temporadas={};
for i=1:size(r,2)
s=strcat('Equipos',r(i),'.txt');
s=char(s);
C=textread(s,'%s');
C=sort(C);
temporadas=[temporadas,C];%Todos los equipos de todas las temporadas
end


Equipos=textread('AllTeams.txt','%s');
datos=cell(380,17,size(Equipos,1));
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
            s=strcat('SP',r(j),'.xlsx');
            s=char(s);
            [n,tmp,x]=xlsread(s);%se usa x
        %buscar partidos de la temporada    
            Ceq=infoTemporada(equipo,x);
            %Guardar partidos en el archivo
            datos(aux:(aux+size(Ceq,1)-1),:,i)=Ceq;
            aux=aux+size(Ceq,1);
        %aumentar j
            j=j+1;
        end
   
    end
    aux
end

save datosPrimeraDiv0304_1213J29;