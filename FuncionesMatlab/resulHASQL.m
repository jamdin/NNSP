function RL=resulHASQL(m,lv)
  
        %Partido Rival H/A FTHG FTAG FTR HS AS HST AST HF AF
    %HC AC HY AY HR AR 

    
    if(strcmp(lv,'local'))
        ga=m{5};
        gr=m{6};
        t=m{8};
        tap=m{10};
        fouls=m{12};
        foulsr=m{13};
        corners=m{14};
        YC=m{16};
        RC=m{18};
        gapt=m{20};
        grpt=m{21};
        
    else
        ga=m{6};
        gr=m{5};
        t=m{9};
        tap=m{11};
        fouls=m{13};
        foulsr=m{12};
        corners=m{15};
        YC=m{17};
        RC=m{19};
        gapt=m{21};
        grpt=m{20};
                
    end
    
        gast=ga-gapt;
        grst=gr-grpt;

%RL=[ga,gr,t,tap,tap/t,fouls,foulsr,corners,YC,RC,gapt,grpt,gast,grst,(1+ga)/(1+gr)];%15 parametros
%Prueba Eliminando parametros

RL=[ga,gr,t,tap,(1+ga)/(1+gr)];


end