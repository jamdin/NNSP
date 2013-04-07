function [Res,h,ag]=predecirPartido(datos,teams,nombreLocal,nombreVisitante,jornada)

load RedNeuronal.mat
%load datosPrimeraDiv0506_1213J29

ventana=10;
%teams=textread('AllTeams.txt','%s');

%Encontrar datos del equipo
loc=strcmp(teams(:,1),nombreLocal);
datoslocal=datos(:,:,loc);

vis=strcmp(teams(:,1),nombreVisitante);
datosvis=datos(:,:,vis);

z=zeros(1,12);
ag=1;

[dgeneral]=encontrarPartido(datoslocal, 'general', ventana, jornada);

if dgeneral==z
    ag=0;
    general=1;
end

[dgeneralrival]=encontrarPartido(datosvis, 'general', ventana, jornada);

if dgeneralrival==z
    ag=0;
    rival=1;
end

[dlocallocal]=encontrarPartido(datoslocal,'local',5,jornada);%ultimos 5 partidos local

if dlocallocal==z
    ag=0;
    local=1;
end

[dvisvis]=encontrarPartido(datosvis,'visitante',5,jornada);%ultimos 5 partidos visitante

if dvisvis==z
    ag=0;
    vis=1;
end

[ddir]=encontrarPartido(datoslocal,'equipo',ventana,jornada,nombreVisitante);%enfrentamiento directo

if ddir==z
    ag=0;
    dir=1;
end

E=[dgeneral,dgeneralrival,dlocallocal,dvisvis, ddir];

[Res,h]=predict(Theta1,Theta2,mapminmax('apply',E',ms)');
h=h/sum(h);


end
