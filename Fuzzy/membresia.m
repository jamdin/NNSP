function m=membresia(x,b,c)
    a=((x-b)/c).^2;
    m=1/(1+a);
end