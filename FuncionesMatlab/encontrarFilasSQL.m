function [filas,puntosant]=encontrarFilasSQL(datab,equipo,temporada)
    conn=database(datab,'','');
    query=['SELECT * FROM ' equipo '$ WHERE Temporada=''' temporada ''''];
    c=exec(conn,query);
    c=fetch(c,38);
    dat=c.data;
    filas=size(dat,1);
    
    if strcmp(class(filas),'No Data')
       filas=0; 
    end
    puntosant=cell2mat(dat(end,22));
    close(c);
    close(conn);
end