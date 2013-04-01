function C=infoTemporada(equipo,temporada)

    %Rival H/A FTHG FTAG FTR HS AS HST AST HF AF HC AC HY AY HR AR 
    C=cell(1,17);
    i=2;
    j=1;
    while i<size(temporada,1)%todas las jornadas
        temporada(i,3)={eliminarEspacios(char(temporada(i,3)))};
        temporada(i,4)={eliminarEspacios(char(temporada(i,4)))};
        b=estaEnArreglo(equipo,temporada(i,:)');
        
        if b==0
            i=i+1;
        else
            juego=temporada(i,:);
            [ha,Rival]=HomeAway(equipo,juego);
            par=obtenerParametros(juego);
            C(j,:)=[Rival, ha, par];
            i=i+1;
            j=j+1;
        end
       
    end
end