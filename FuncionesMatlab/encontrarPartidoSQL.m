function [d,ptsacum,pos]=encontrarPartidoSQL(datab,equipo,parametro,valorparametro,numejemplos,jornada,temporada)


%ventana puede ser un string o un numero
%datos es un cell de 2 dimensiones que es el resultado de cada equipo.
switch parametro
    case 'General'
        parametro='General';
        valorparametro='';
        RivDir='';
    case 'Local'
        parametro='[H/A]';
        valorparametro='1';
        RivDir='';
    case 'Visitante'
        parametro='[H/A]';
        valorparametro='2';
        RivDir='';
    case 'Equipo'
        parametro='Rival';
        RivDir='';
    case 'DirLocal'
        RivDir=valorparametro;
        parametro='H/A';
        valorparametro='1';
    case 'DirVis'
        RivDir=valorparametro;
        parametro='H/A';
        valorparametro='2';
end

 dat=encontrarSQL(datab,equipo,parametro,valorparametro,numejemplos,jornada,num2str(temporada),RivDir);
 if size(dat,2)==1
     d=zeros(1,8);
     ptsacum=0;
     pos=0;
     entro=1;
 else
 [d,ptsacum,pos]=PartidosSQL(dat);
 end
end
 



