function se=eliminarEspacios(nombre)
    
            esp=find(char(nombre)==' ');
            se=char(nombre);
            if size(esp,2)>0

                for l=1:size(esp,2)
                    
                r2=[se(1:esp(l)-1),se(esp(l)+1:end)];
                end
            se=r2;    
            end
end