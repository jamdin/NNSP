function E=generarDatos(datoscomp,datosequipo, jornada)

ventana=10;
teams=textread('AllTeams.txt','%s');

r= strcmp(datosequipo(:,1),jornada);
rival=datosequipo(r,2);
riv=strcmp(teams(:,1),rival);
datosrival=datoscomp(:,:,riv);

%Definir Local y Visitante
ha=datosequipo{r,3};
ftr=datosequipo{r,6};
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
    case 1,%gano el visitante
        if ha==1%es local
            resultado=3;
        else%es visitante
            resultado=1;
        end
    case 2,%gano el local
        if ha==1%es local
            resultado=1;
        else%es visitante
            resultado=3;
        end
    case 3,%empataron
        resultado=2;
end


[dgeneral]=encontrarPartido(datosequipo, 'general', ventana, jornada);

[dgeneralrival]=encontrarPartido(datosrival, 'general', ventana, jornada);

[dlocallocal]=encontrarPartido(datoshome,'local',5,jornada);%ultimos 5 partidos local

[dvisvis]=encontrarPartido(datosaway,'visitante',5,jornada);%ultimos 5 partidos visitante

[ddir]=encontrarPartido(datosequipo,'equipo',ventana,jornada,rival);%enfrentamiento directo

[ddirL]=encontrarPartido(datoshome,'equipolocal',5,jornada,nomAway);

[ddirV]=encontrarPartido(datosaway,'equipovisitante',5,jornada,nomLocal);

E=[dgeneral,dgeneralrival,dlocallocal,dvisvis,ddir, ddirL, ddirV, resultado];


end