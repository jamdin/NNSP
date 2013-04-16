function [n,fila]=ultimoPartido(datos)

c=cellfun(@isempty,datos);
f=find(c==1);
nu=f(1);
fila=nu-1;
n=datos(nu-1,1);

end