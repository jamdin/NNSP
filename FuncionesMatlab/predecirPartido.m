function [Res,h,ag]=predecirPartido(c,datos,teams,nombreLocal,nombreVisitante,jornada)

%load RedNeuronal2.mat%Entrenada con solo Espana
%load RedNeuronal2.mat%Entrenada con Espana e Inglaterra
%load datosPrimeraDiv0506_1213J29

Theta1=c{1};
Theta2=c{2};
ms=c{3};

ventana=3;
part=str2double(jornada(5:end));
%teams=textread('AllTeams.txt','%s');

%Encontrar datos del equipo
loc=strcmp(teams(:,1),nombreLocal);
datoslocal=datos(:,:,loc);

vis=strcmp(teams(:,1),nombreVisitante);
datosvis=datos(:,:,vis);

z=zeros(1,8);
ag=1;

[dgeneral,ptslocal,poslocal]=encontrarPartido(datoslocal, 'general', ventana, jornada);

if dgeneral==z
    ag=0;
    general=1;
end

[dgeneralrival,ptsvis,posvis]=encontrarPartido(datosvis, 'general', ventana, jornada);

if dgeneralrival==z
    ag=0;
    rival=1;
end

[dlocallocal]=encontrarPartido(datoslocal,'local',ventana,jornada);%ultimos 5 partidos local

if dlocallocal==z
    ag=0;
    local=1;
end

[dvisvis]=encontrarPartido(datosvis,'visitante',ventana,jornada);%ultimos 5 partidos visitante

if dvisvis==z
    ag=0;
    vis=1;
end

[ddir]=encontrarPartido(datoslocal,'equipo',ventana,jornada,nombreVisitante);%enfrentamiento directo

if ddir==z
    ag=0;
    dir=1;
end

    part=part-1;
if part==0
    puntosh=0;
    puntosa=0;
else

puntosh=100*(ptslocal)/(part);
puntosa=100*(ptsvis)/(part);
end

posrelativa=abs(poslocal-posvis)/20;

E=[dgeneral,dgeneralrival,dlocallocal,dvisvis,ddir,...
    puntosh,puntosa,poslocal,posvis,posrelativa];%Cambiado el ultimo termino de resultado -> goles
                


%E=[dgeneral,dgeneralrival,dlocallocal,dvisvis, ddir];

%Res=sim(net,mapminmax('apply',E',ms)');
 [Res,h]=predict(Theta1,Theta2,mapminmax('apply',E',ms)');
 h=h/sum(h);


end
