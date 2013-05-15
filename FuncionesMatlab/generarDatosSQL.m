function [Eloc,Evis,Edir,ag]=generarDatosSQL(datab,datosequipo, fila,nomEquipo)

ventana=10;

temporada=datosequipo{fila,1};
jornada=datosequipo{fila,2};
rival=char(datosequipo(fila,3));

datosrival=teamData(datab,rival);


%Definir Local y Visitante
ha=datosequipo{fila,4};
ftr=datosequipo{fila,7};


z=zeros(1,8);
ag=1;

if ha==1 %Local
    datoshome=datosequipo;
    datosaway=datosrival;
    nomLocal=nomEquipo;
    nomAway=rival;

else %Visitante 
    datosaway=datosequipo;
    datoshome=datosrival;
    nomAway=nomEquipo;
    nomLocal=rival;

end

disp([nomLocal, ' ',nomAway]);


[dglocal,ptslocal,poslocal]=encontrarPartidoSQL(datab,nomLocal,'General','', ventana, jornada,temporada);%Se cambio de datosequipo a datoshome
                                             
if dglocal==z
    ag=0;
    local=0
end

[dgvis,ptsvis,posvis]=encontrarPartidoSQL(datab,nomAway,'General','', ventana, jornada,temporada);

if dgvis==z
    ag=0;
    visitante=0
end

[dlocallocal]=encontrarPartidoSQL(datab,nomLocal,'Local','', ventana, jornada,temporada);%ultimos 5 partidos local

if dlocallocal==z
    ag=0;
    locall=0
end

[dvisvis]=encontrarPartidoSQL(datab,nomAway,'Visitante','', ventana, jornada,temporada);%ultimos 5 partidos visitante

if dvisvis==z
    ag=0;
    visvis=0
end

[ddir]=encontrarPartidoSQL(datab,nomLocal,'Equipo',nomAway, ventana, jornada,temporada);%enfrentamiento directo

if ddir==z
    ag=0;
    dir=0
end

[ddirL]=encontrarPartidoSQL(datab,nomLocal,'DirLocal',nomAway, ventana, jornada,temporada);

if ddirL==z
    ag=0;
    dirL=0
end

[ddirV]=encontrarPartidoSQL(datab,nomAway,'DirVis',nomLocal, ventana, jornada,temporada);

if ddirV==z
    ag=0;
    dirV=0
end

    part=jornada-1;
if part==0
    puntosh=0;
    puntosa=0;
else

puntosh=100*(ptslocal)/(part);
puntosa=100*(ptsvis)/(part);
end

posrelativa=abs(poslocal-posvis)/20;

switch ftr
    case 1
        resloc=1;
        resdir=1;
        resvis=3;
    case 2
        resloc=2;
        resdir=2;
        resvis=2;
    case 3
        resloc=3;
        resdir=3;
        resvis=1;

end

Eloc=[dglocal,dlocallocal,puntosh,resloc];
Evis=[dgvis,dvisvis,puntosa,resvis];
Edir=[ddir,ddirL,ddirV,posrelativa,resdir];

% E=[dgeneral,dgeneralrival,dlocallocal,dvisvis,ddir,...
%     puntosh,puntosa,poslocal,posvis,posrelativa,ftr];
            

end