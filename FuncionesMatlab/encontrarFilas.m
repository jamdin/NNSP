function filas=encontrarFilas(archivoxls,equipo)

    filas=[];
    for i=1:size(archivoxls,1)
        archivoxls(i,3)={eliminarEspacios(char(archivoxls(i,3)))};
        archivoxls(i,4)={eliminarEspacios(char(archivoxls(i,4)))};
        b=estaEnArreglo(equipo,archivoxls(i,:)');
        if b==1
            filas=[filas;i];
        end
    end

end