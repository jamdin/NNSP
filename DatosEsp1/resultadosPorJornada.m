function prom=resultadosPorJornada(jornada)

[n,tmp,x]=xlsread('SP1213.xlsx');%se usa x
temporada='1213';
j=jornada-1;
jor=cell(10,3);

if jornada==1
       temporada='1112';
       j=38;
end

part=strcat(temporada,num2str(j));

for i=1:10
    fila=(10*j+1+i);
    juego=x(fila,:);
    ahd=juego(1,7);
    if char(ahd)=='A'
        FTR=1;
    elseif char(ahd)=='H'
        FTR=2;
    else
        FTR=3;
    end
    local=juego(1,3);
    vis=juego(1,4);
    lvp={eliminarEspacios(char(local)),eliminarEspacios(char(vis)),FTR};
    jor(i,:)=lvp;
end

if exist('datos','var')==0
load datosPrimeraDiv0506_1213J29.mat
end

for i=1:10
R(i)=predecirPartido(datos,jor(i,1),jor(i,2),part);
    
end
res=jor(:,3);
prom=mean(double(cell2mat(res)==R'));
end