function ptos=puntosSQL(datab,equipo,temporada)
    conn=database(datab,'','');
    sel=['SELECT * FROM ' equipo '$ WHERE Temporada=''' temporada ''''];
    c=exec(conn,sel);
    c=fetch(c,38);
    dat=c.data;
    ptos=cell2mat(dat(end,22));
    close(conn);
    
end