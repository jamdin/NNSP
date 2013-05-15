function y=encontrar_y(y_lim,md)
    num=y_lim*md';
    den=sum(md);
    y=num/den;
end