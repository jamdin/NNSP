function [E,ag2]=generarDatosFuzzy(path,datoscomp,datosequipo, jornada)

ventana=5;
ventanadir=2;
ymin=-5;
ymax=+5;
ag2=1;

teams=textread([path,'AllTeams.txt'],'%s');

r= strcmp(datosequipo(:,1),jornada);
rival=datosequipo(r,2);
riv=strcmp(teams(:,1),rival);
datosrival=datoscomp(:,:,riv);

part=str2double(jornada(5:end));

%Definir Local y Visitante
ha=datosequipo{r,3};
ftr=datosequipo{r,6};
gh=datosequipo(r,4);
ga=datosequipo(r,5);

z=zeros(1,ventana);
zdir=zeros(1,ventanadir);

if ha==1 %Local
    datoshome=datosequipo;
    datosaway=datosrival;
    nomLocal=datosrival(r,2);
    nomAway=rival;

else %Visitante
    ag2=0;
    datosaway=datosequipo;
    datoshome=datosrival;
    nomAway=datosrival(r,2);
    nomLocal=rival;

end



[dgeneral,ag]=encontrarPartidoFuzzy(datoshome,ymin,ymax,'general',ventana,jornada);%Se cambio de datosequipo a datoshome

if ag==0
    ag2=0;
end

[dgeneralrival,ag]=encontrarPartidoFuzzy(datosaway,ymin,ymax,'general',ventana,jornada);

if ag==0
    ag2=0;
end
% 
% [dlocallocal]=encontrarPartido(datoshome,'local',ventana,jornada);%ultimos 5 partidos local
% 
% if dlocallocal==z
%     ag=0;
% end
% 
% [dvisvis]=encontrarPartido(datosaway,'visitante',ventana,jornada);%ultimos 5 partidos visitante
% 
% if dvisvis==z
%     ag=0;
% end

[ddir,ag]=encontrarPartidoFuzzy(datoshome,ymin,ymax,'equipo',ventanadir,jornada,rival);%enfrentamiento directo

if ag==0
    ag2=0;
end

y=cell2mat(gh)-cell2mat(ga);
y=truncar(y,ymin,ymax);
E=[dgeneral,dgeneralrival,ddir,y];
if y<-2
    p=1;
elseif y>-3&&y<0
    p=2;
elseif y==0
    p=3;
elseif y>0&&y<3
    p=4;
else
    p=5;
end
E=[E,p];
if size(E,2)~=14
    ag2=0;
end

end