function b=estaEnArreglo(str,C)
%Devuelve 1 si se encuentra en el arreglo y 0 si no


    b=0;
    i=1;
    while b==0 && i<=size(C,1) 
    b=strcmp(str,C(i));
    i=i+1;
    end

end