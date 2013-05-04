function se=eliminarEspacios(nombre)
    
            esp=find(char(nombre)==' ');
            se=char(nombre);
            if size(esp,2)>0

                while size(esp,2)>0
                    
                r2=[se(1:esp(1)-1),se(esp(1)+1:end)];
                se=r2;
                esp=find(char(se)==' ');
                end
            end
            
            esp=find(char(se)=='''');
            if size(esp,2)>0

                while size(esp,2)>0
                    
                r2=[se(1:esp(1)-1),se(esp(1)+1:end)];
                se=r2;
                esp=find(char(se)==' ');
                end
            end
            
end