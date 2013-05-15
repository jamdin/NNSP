function datosequipo=teamData(datab,nombreEquipo)

sel=['SELECT * FROM ' nombreEquipo '$'];
        conn=database(datab,'','');
        c=exec(conn,sel);
        c=fetch(c);
        datosequipo=c.data;
        close(conn)
end