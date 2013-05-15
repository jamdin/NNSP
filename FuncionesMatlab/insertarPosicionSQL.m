function i=insertarPosicionSQL(datab,equipo,posicion,temporada)
    conn=database(datab,'','');
    sel=['SELECT * FROM ' equipo '$ WHERE Temporada=''' temporada ''''];
    c=exec(conn,sel);
    c=fetch(c,38);
    jor=num2str(size(c.data,1));
    upd=['UPDATE ' equipo '$ SET Posicion=''' posicion ''' WHERE  Temporada=''' temporada ''' AND Jornada=''' jor ''''];
    c=exec(conn,upd);
    c.Message;
    close(conn);
    i=1;
end