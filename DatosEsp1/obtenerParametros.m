function par=obtenerParametros(juego)
    %Pasar Resultado A,H,D a numero 1,2,3
    ahd=juego(1,7);
    if char(ahd)=='A'
        FTR=1;
    elseif char(ahd)=='H'
        FTR=2;
    else
        FTR=3;
    end
    
    par=[juego(1,5:6),FTR,juego(1,11:22)];
    


end