function C=infoTemporadaSQL(equipo,archivoxls,temporada,jornada,fila,ptosant)

    %PartidoRival H/A FTHG FTAG FTR HS AS HST AST HF AF
    %HC AC HY AY HR AR 
            archivoxls(fila,3)={eliminarEspacios(char(archivoxls(fila,3)))};
            archivoxls(fila,4)={eliminarEspacios(char(archivoxls(fila,4)))};
            
            juego=archivoxls(fila,:);
            [ha,Rival]=HomeAway(equipo,juego);
            [par,FTR]=obtenerParametros(juego);
            p=calcularPuntos(ha,FTR);
            puntos=ptosant+p;
            
            C=[temporada,jornada, Rival, ha, par,puntos];%Separado temporada y jornada
          
end