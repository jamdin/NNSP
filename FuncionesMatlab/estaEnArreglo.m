function b=estaEnArreglo(str,C)
%Devuelve 1 si str se encuentra en el arreglo C y 0 si no


    b=0;
    i=1;
    while b==0 && i<=size(C,1) 
    b=strcmp(str,C(i));
    i=i+1;
    end

end