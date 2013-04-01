function d=encontrarPartido(datos,equipo,parametro,valorparametro,numpartido)
d=0;
if (strcmp(parametro,'local'))
    if exist('numpartido','var')==0
       numpartido=ultimoPartido;%Encontrar ultimo partido usando la funcion cellfun isempty 
    end
    
elseif(strcmp(parametro,'visitante'))
    
    
elseif(strcmp(parametro,'equipo'))
    
    
else
    d=0;
end
end