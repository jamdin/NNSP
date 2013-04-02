function d=encontrarPartido(datosequipo, parametro, ventana, numpartido, nombreequipo)

%ventana puede ser un string o un numero
%datos es un cell de 2 dimensiones que es el resultado de cada equipo.

d={};

if strcmp(numpartido,'ultimo')
       numpartido=ultimoPartido(datosequipo);%Encontrar ultimo partido
end

if (strcmp(parametro,'local'))
    inddat=[datosequipo{:,3}]==1;
    dat=datosequipo(inddat,:);
    
    r=find(strcmp(dat(:,1),numpartido));
    if size(r,1)==0%Si el ultimo partido es de visitante, selecciona al ultimo de local
        if size(dat,1)~=0
        numpartido=dat(size(dat,1),1);
        end
    end
    
    if size(dat,1)==0
        d=zeros(1,12);
    else
    
    d=Partidos(dat,ventana,numpartido);
    end
elseif(strcmp(parametro,'visitante'))
    inddat=[datosequipo{:,3}]==2;
    dat=datosequipo(inddat,:);
    
        r=find(strcmp(dat(:,1),numpartido));

    if size(r,1)==0%Si el ultimo partido es de local, selecciona el ultimo de visitante
        if size(dat,1)~=0
        numpartido=dat(size(dat,1),1);
        end
    end    
    if size(dat,1)==0
        d=zeros(1,12);
    else
    
    d=Partidos(dat,ventana,numpartido);
    end
elseif(strcmp(parametro,'equipo'))
    
    inddat= strcmp(datosequipo(:,2),nombreequipo);
    dat=datosequipo(inddat,:);
    
     r=find(strcmp(dat(:,1),numpartido));

    if size(r,1)==0%Si el ultimo partido no fue contra ese equipo, selecciona el ultimo contra el equipo
      if size(dat,1)~=0
        numpartido=dat(size(dat,1),1);
      end
    end
    
    if size(dat,1)==0
        d=zeros(1,12);
    else
    
    d=Partidos(dat,ventana,numpartido);
    end
    
elseif(strcmp(parametro,'equipovisitante'))%Contra un equipo jugando de visitante
    
    inddat= strcmp(datosequipo(:,2),nombreequipo);
    dat=datosequipo(inddat,:);
    inddat=[dat{:,3}]==2;
    dat=dat(inddat,:);
    
     r=find(strcmp(dat(:,1),numpartido));

    if size(r,1)==0%Si el ultimo partido no fue contra ese equipo, selecciona el ultimo contra el equipo
      if size(dat,1)~=0
        numpartido=dat(size(dat,1),1);
      end
    end
    
    if size(dat,1)==0
        d=zeros(1,12);
    else
    
    d=Partidos(dat,ventana,numpartido);
    end
elseif(strcmp(parametro,'equipolocal'))%Contra un equipo jugando de local
    
    inddat= strcmp(datosequipo(:,2),nombreequipo);
    dat=datosequipo(inddat,:);
    inddat=[dat{:,3}]==1;
    dat=dat(inddat,:);
    
     r=find(strcmp(dat(:,1),numpartido));

    if size(r,1)==0%Si el ultimo partido no fue contra ese equipo, selecciona el ultimo contra el equipo
      if size(dat,1)~=0

        numpartido=dat(size(dat,1),1);
      end
    end
    
    if size(dat,1)==0
        d=zeros(1,12);
    else
    d=Partidos(dat,ventana,numpartido);
    end
    
elseif(strcmp(parametro,'general'))
 d=Partidos(datosequipo,ventana,numpartido);
    
else
    d={};
end

end
