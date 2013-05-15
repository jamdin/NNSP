function i=insertarSQL(datab,equipo,C)
    conn=database(datab,'','');
    colname={'Temporada','Jornada', 'Rival', '[H/A]', 'HG', 'AG', 'FTR',...
        'HS', 'AShots', 'HST', 'AST', 'HF', 'AG', 'HC', 'AC', 'HY', 'AY', 'HR',...
        'AR', 'HTHG', 'HTAG', 'Puntos', 'Posicion'};
    tabla=strcat(equipo,'$');
    %Transformar Datos a string
    C(1,2)={num2str(cell2mat(C(1,2)))};
    for i=4:size(C,2)
        C(1,i)={num2str(cell2mat(C(1,i)))};
    end
%    insert(conn,tabla,colname,C);
    query=['INSERT INTO ' equipo '$ VALUES ('];
    for i=1:(size(C,2)-1)
       query=[query, '''', char(C(1,i)), ''','];        
    end
        query=[query,'''', char(C(1,end)), ''')'];
     c=exec(conn,query);
    close(conn);
    i=1;
end