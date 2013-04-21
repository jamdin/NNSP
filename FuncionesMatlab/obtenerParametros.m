function [par,FTR]=obtenerParametros(juego)
    %Pasar Resultado H,D,A a numero 1,2,3
    ahd=juego(1,7);
    if char(ahd)=='H'
        FTR=1;
    elseif char(ahd)=='D'
        FTR=2;
    else
        FTR=3;
    end
    
    par=[juego(1,5:6),FTR,juego(1,11:22),juego(1,8:9)];
    


end