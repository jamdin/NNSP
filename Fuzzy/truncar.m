function num=truncar(numero,min,max)
    %Trunca el numero a [min,max]
    mas= numero>max;
    numero(mas)=max;
    menos= numero<min;
    numero(menos)=min;
    num=numero;
        
end