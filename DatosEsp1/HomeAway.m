function [ha,Rival]=HomeAway(equipo,juego)
    %Home=1
    %Away=2

    haw=strcmp(equipo,juego(1,4));
    
    if haw==0 %Home
        Rival=juego(1,4);
        ha=1;
    else %Away
        Rival=juego(1,3);
        ha=2;
    end
    
end