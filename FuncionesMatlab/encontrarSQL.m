function datos=encontrarSQL(datab,equipo,parametro,valorparametro,numejemplos,jornada,temporada,RivDir)

    conn=database(datab,'','');
    if strcmp(parametro,'General')
        sel=['SELECT TOP ' num2str(numejemplos) ' * FROM ' equipo '$ WHERE'...
            '(Temporada=''' temporada ''' AND Jornada<' num2str(jornada) ' OR Temporada<''' temporada ''')'...
        ' ORDER BY Temporada Desc, Jornada Desc'];
    elseif strcmp(parametro,'H/A')
        sel=['SELECT TOP ' num2str(numejemplos) ' * FROM ' equipo '$ WHERE [H/A]=''' valorparametro ''''...
        ' AND Rival=''' RivDir ''' AND (Temporada=''' temporada ''' AND Jornada<' num2str(jornada) ' OR Temporada<''' temporada ''')'...
        ' ORDER BY Temporada Desc, Jornada Desc'];
    else
        sel=['SELECT TOP ' num2str(numejemplos) ' * FROM ' equipo '$ WHERE ' parametro '=''' valorparametro ''''...
        ' AND (Temporada=''' temporada ''' AND Jornada<' num2str(jornada) ' OR Temporada<''' temporada ''')'...
        ' ORDER BY Temporada Desc, Jornada Desc'];
    end
    c=exec(conn,sel);
    c=fetch(c,numejemplos);
    datos=c.data;
    close(conn)
    

end