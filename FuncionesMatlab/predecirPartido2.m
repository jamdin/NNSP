function [Res,h,ag]=predecirPartido2(c,datos,teams,nombreLocal,nombreVisitante,jornada)

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
datoshome=datos(:,:,loc);

vis=strcmp(teams(:,1),nombreVisitante);
datosaway=datos(:,:,vis);

z=zeros(1,9);
ag=1;

[dgeneral,ptslocal,poslocal]=encontrarPartido(datoshome, 'general', ventana, jornada);%Se cambio de datosequipo a datoshome

if dgeneral==z
    ag=0;
end

[dgeneralrival,ptsvis,posvis]=encontrarPartido(datosaway, 'general', ventana, jornada);

if dgeneralrival==z
    ag=0;
end

[dlocallocal]=encontrarPartido(datoshome,'local',ventana,jornada);%ultimos 5 partidos local

if dlocallocal==z
    ag=0;
end

[dvisvis]=encontrarPartido(datosaway,'visitante',ventana,jornada);%ultimos 5 partidos visitante

if dvisvis==z
    ag=0;
end

[ddir]=encontrarPartido(datoshome,'equipo',ventana,jornada,nombreVisitante);%enfrentamiento directo

if ddir==z
    ag=0;
end

[ddirL]=encontrarPartido(datoshome,'equipolocal',5,jornada,nombreVisitante);

[ddirV]=encontrarPartido(datosaway,'equipovisitante',5,jornada,nombreLocal);

    part=part-1;
if part==0
    puntosh=0;
    puntosa=0;
else

puntosh=100*(ptslocal)/(part);
puntosa=100*(ptsvis)/(part);
end

posrelativa=abs(poslocal-posvis)/20;


E=[dgeneral,dgeneralrival,dlocallocal,dvisvis,ddir,ddirL,ddirV...
    puntosh,puntosa,poslocal,posvis,posrelativa];%Cambiado el ultimo termino de resultado -> goles
                                                                    %Agrega
                                                                    %do cell2mat
                


%E=[dgeneral,dgeneralrival,dlocallocal,dvisvis, ddir];

%Res=sim(net,mapminmax('apply',E',ms)');
 [Res,h]=predict(Theta1,Theta2,mapminmax('apply',E',ms)');
 %h=h/sum(h);


end
