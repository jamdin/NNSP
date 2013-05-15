function [R,ptsacum,pos]=resultadosSQL(datos_ventana,ventana)
    %Hay que ver si jugo de local o de visitante para ver el resultado en 
    %la col 6.
    %Resultado H=1,D=2,A=3
    %L/V H=1,A=2
    
    RL=zeros(1,5);
    w=0;
    l=0;
    d=0;
    for i=1:size(datos_ventana,1)

       m=datos_ventana(i,:);
      ptosac=m{22};
      posicion=m{23};
     switch m{7}
         case 1,%Gano el local
             if m{4}==1 %si fue local
                 w=w+1;
                  RL=RL+resulHASQL(m,'local');
             else %si fue visitante
                 l=l+1;
                 RL=RL+resulHASQL(m,'visitante');
             end
         case 2,%Empataron
            d=d+1;
             if m{4}==1 %si fue local
                 RL=RL+resulHASQL(m,'local');
             else %si fue visitante
                 RL=RL+resulHASQL(m,'visitante');
             end
             
         case 3,%Gano el visitante
            if m{4}==1 %si fue local
                 l=l+1;
                 RL=RL+resulHASQL(m,'local');
             else %si fue visitante
                 w=w+1;
 
                 RL=RL+resulHASQL(m,'visitante');
            end
     
     end
        
    end
%R=100*[w,d,l,RL]/ventana;%18 Parametros
%R=[ganados, empatados, perdidos, goles anotados, goles recibidos, tiros,
%tiros a puerta, faltas, faltas recibidas, corners, tarjetas amarillas,
%tarjetas rojas]
R=[w,d,l,RL]/ventana;%8 parametros
ptsacum=ptosac;
pos=posicion;
end