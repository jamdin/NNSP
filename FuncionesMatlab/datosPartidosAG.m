[ptas,pathAG]=encontrarPaths;

liga='Francia';
jornada='121332';


    switch liga
        case 'Espana'
            load datosEsp0506_1213_puntos.mat
            teams=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalSptos2
            s=[ptas{1},'Jornada31Esp.xlsx'];
            dir='PartidosJ31Esp_conNombres.txt';
        case 'Inglaterra'
            load datosIng0506_1213_puntos.mat
            teams=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalEptos2
            s=[ptas{2},'Jornada31Ing.xlsx'];
            dir='PartidosJ31Ing_conNombres.txt';
        case 'Alemania'
            load datosAle0506_1213_puntos.mat
            teams=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalDptos2
            s=[ptas{3},'Jornada28Ale.xlsx'];
            dir='PartidosJ28Ale_conNombres.txt';
        case 'Italia'
            load datosIta0506_1213_puntos.mat
            teams=textread([ptas{4} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalIptos2
            s=[ptas{4},'Jornada31Ita.xlsx'];
            dir='PartidosJ31Ita_conNombres.txt';
        case 'Francia'
            load datosFra0506_1213_puntos.mat
            teams=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalFptos2
            s=[ptas{5},'Jornada31Fra.xlsx'];
            dir='PartidosJ31Fra_conNombres.txt';
    end
    
    [n,t,x]=xlsread(s);
    c={Theta1;Theta2;ms};
    pred=cell(size(x,1),8);

for i=1:size(x,1)
    eqlocal=eliminarEspacios(x{i,1});
    eqvis=eliminarEspacios(x{i,2});
    [p,h]=predecirPartido(c,datos,teams,eqlocal,eqvis,jornada);
     ap=x(i,3:5);
    pred(i,:)=[x(i,1),x(i,2),num2cell(h),ap];
    
end

%Sin Nombres
%  fid = fopen([pathAG,'PartidosJ31Esp_conNombres.txt'], 'wt');
% fprintf(fid, [repmat('%g\t', 1, size(pred,2)-1) '%g\n'], roundn(pred,-4).');
% fclose(fid);

%Con Nombres
fid = fopen([pathAG,dir], 'wt');
for i=1:size(pred,1)
fprintf(fid,'%s\t%s\t%g\t%g\t%g\t%g\t%g\t%g\n',pred{i,:});
end
fclose(fid);