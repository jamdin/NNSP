function [Res,h,ag]=predecirPartidoPrueba(c1,c2,c3,c4,datos,teams,nombreLocal,nombreVisitante,jornadaLocal,jornadaVis)

%load RedNeuronal2.mat%Entrenada con solo Espana
%load RedNeuronal2.mat%Entrenada con Espana e Inglaterra
%load datosPrimeraDiv0506_1213J29

ventana=5;
%teams=textread('AllTeams.txt','%s');
jorLocal=['1213',num2str(jornadaLocal)];
jorVis=['1213',num2str(jornadaVis)];
%Encontrar datos del equipo
loc=strcmp(teams(:,1),nombreLocal);
datoshome=datos(:,:,loc);

vis=strcmp(teams(:,1),nombreVisitante);
datosaway=datos(:,:,vis);

z=zeros(1,9);
ag=1;

[dgeneral,ptslocal,poslocal]=encontrarPartido(datoshome, 'general', ventana, jorLocal);%Se cambio de datosequipo a datoshome

if dgeneral==z
    ag=0;
end

[dgeneralrival,ptsvis,posvis]=encontrarPartido(datosaway, 'general', ventana, jorVis);

if dgeneralrival==z
    ag=0;
end

[dlocallocal]=encontrarPartido(datoshome,'local',ventana,jorLocal);%ultimos 5 partidos local

if dlocallocal==z
    ag=0;
end

[dvisvis]=encontrarPartido(datosaway,'visitante',ventana,jorVis);%ultimos 5 partidos visitante

if dvisvis==z
    ag=0;
end

[ddir]=encontrarPartido(datoshome,'equipo',ventana,jorLocal,nombreVisitante);%enfrentamiento directo

if ddir==z
    ag=0;
end

[ddirL]=encontrarPartido(datoshome,'equipolocal',5,jorLocal,nombreVisitante);

[ddirV]=encontrarPartido(datosaway,'equipovisitante',5,jorVis,nombreLocal);


posrelativa=abs(poslocal-posvis)/20;



Ejloc=[dgeneral,dlocallocal,ddirL,poslocal];
Ejdir=[ddir,ddirL,ddirV,posrelativa];
Ejvis=[dgeneralrival,dvisvis,ddirV,posvis];                                                                   

 
Theta1=c1{1};
Theta2=c1{2};
ms=c1{3};
[Res,h1]=predict(Theta1,Theta2,mapminmax('apply',Ejloc',ms)');
Theta1=c2{1};
Theta2=c2{2};
ms=c2{3};
[Res,h2]=predict(Theta1,Theta2,mapminmax('apply',Ejdir',ms)');
Theta1=c3{1};
Theta2=c3{2};
ms=c3{3};
[Res,h3]=predict(Theta1,Theta2,mapminmax('apply',Ejvis',ms)');
Theta1=c4{1};
Theta2=c4{2};
ms=c4{3};
[Res,h]=predict(Theta1,Theta2,mapminmax('apply',[h1,h2,h3]',ms)');
% h=h/sum(h);


end
