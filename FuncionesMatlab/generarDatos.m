function [E,ag]=generarDatos(path,datoscomp,datosequipo, jornada)

ventana=10;
% 
% paths=encontrarPaths;
% path=paths{5};%paths{1} Espana
%               %paths{2} Inglaterra
%               %paths{3} Alemania
%               %paths{4} Italia
%               %paths{5} Francia

teams=textread([path,'AllTeams.txt'],'%s');

r= strcmp(datosequipo(:,1),jornada);
rival=datosequipo(r,2);
riv=strcmp(teams(:,1),rival);
datosrival=datoscomp(:,:,riv);

%Definir Local y Visitante
ha=datosequipo{r,3};
ftr=datosequipo{r,6};

z=zeros(1,12);
ag=1;

if ha==1 %Local
    datoshome=datosequipo;
    datosaway=datosrival;
    nomLocal=datosrival(r,2);
    nomAway=rival;
else %Visitante 
    datosaway=datosequipo;
    datoshome=datosrival;
    nomAway=datosrival(r,2);
    nomLocal=rival;
  
end

%resultado Gano(1), Empato(2), Perdio(3)
switch ftr
    case 1,%gano el local
        if ha==1%es local
            resultado=1;
        else%es visitante
            resultado=3;
        end
    case 2,%empataron

            resultado=2;

    case 3,%Gano el visitante
        if ha==1%es local
            resultado=3;
        else%es visitante
            resultado=1;
        end
end


[dgeneral]=encontrarPartido(datosequipo, 'general', ventana, jornada);

if dgeneral==z
    ag=0;
end

[dgeneralrival]=encontrarPartido(datosrival, 'general', ventana, jornada);

if dgeneralrival==z
    ag=0;
end

[dlocallocal]=encontrarPartido(datoshome,'local',5,jornada);%ultimos 5 partidos local

if dlocallocal==z
    ag=0;
end

[dvisvis]=encontrarPartido(datosaway,'visitante',5,jornada);%ultimos 5 partidos visitante

if dvisvis==z
    ag=0;
end

[ddir]=encontrarPartido(datosequipo,'equipo',ventana,jornada,rival);%enfrentamiento directo

if ddir==z
    ag=0;
end

%[ddirL]=encontrarPartido(datoshome,'equipolocal',5,jornada,nomAway);

%[ddirV]=encontrarPartido(datosaway,'equipovisitante',5,jornada,nomLocal);

E=[dgeneral,dgeneralrival,dlocallocal,dvisvis,ddir,resultado];


end