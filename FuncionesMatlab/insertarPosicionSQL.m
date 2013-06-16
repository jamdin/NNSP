function i=insertarPosicionSQL(datab,equipo,posicion,temporada,jeq)
    conn=database(datab,'','');
    sel=['SELECT * FROM ' equipo '$ WHERE Temporada=''' temporada ''''];
    c=exec(conn,sel);
    c=fetch(c,38);
    f=find(jeq==1);
    for i=1:size(f,1)
    jor=num2str(f(i));
    upd=['UPDATE ' equipo '$ SET Posicion=''' posicion ''' WHERE  Temporada=''' temporada ''' AND Jornada=''' jor ''''];
    c=exec(conn,upd);
    end
    c.Message;
    close(conn);
    i=1;
end