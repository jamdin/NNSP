function [R]=resultadosFuzzy(datos_ventana,ventana,ymin,ymax)
    %Hay que ver si jugo de local o de visitante para ver el resultado en 
    %la col 6.
    %Resultado H=1,D=2,A=3
    %L/V H=1,A=2
    R=zeros(1,ventana);
    for i=1:size(datos_ventana,1)

       m=datos_ventana(i,:);
     switch m{3}
         case 1,%local
             if m{3}==1 %si fue local
                ga=m{4};
                gr=m{5};
             end
         case 2,%visitante
                ga=m{5};
                gr=m{4};
                  
      end
     y=ga-gr;
     R(i)=truncar(y,ymin,ymax);
     end
        
    

end