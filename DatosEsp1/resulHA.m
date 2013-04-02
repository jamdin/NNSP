function RL=resulHA(m,lv)
  
        %Partido Rival H/A FTHG FTAG FTR HS AS HST AST HF AF
    %HC AC HY AY HR AR 

    
    if(strcmp(lv,'local'))
        ga=m{4};
        gr=m{5};
        t=m{7};
        tap=m{9};
        fouls=m{11};
        foulsr=m{12};
        corners=m{13};
        YC=m{15};
        RC=m{17};      
        
    else
        ga=m{5};
        gr=m{4};
        t=m{8};
        tap=m{10};
        fouls=m{12};
        foulsr=m{11};
        corners=m{14};
        YC=m{16};
        RC=m{18};    
                
    end

RL=[ga,gr,t,tap,fouls,foulsr,corners,YC,RC];

end