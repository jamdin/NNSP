function puntos=calcularPuntos(ha,FTR)

    %FTR=1(Home),2(Draw),3(Away)
    %ha=1(Home),2(Away)
    
    switch FTR
    
        case 1%Gano el Local
            if ha==1%Si fue local
                puntos=3;
            else%si fue visitante
                puntos=0;
            end
        case 2%empataron
            puntos=1;
        case 3%Gano el visitante
            if ha==2%si fue visitante
                puntos=3;
            else
                puntos=0;
            end
        
    end


end