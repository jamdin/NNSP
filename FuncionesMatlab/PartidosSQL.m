function [D,ptsacum,pos] = PartidosSQL(datos)
%datos del equipo
%ventana: numero de partidos
%numpartido: a partir de cual partido

ventana=size(datos,1);%encuentra el numero de fila del partido

[D,ptsacum,pos]=resultadosSQL(datos,ventana);
end