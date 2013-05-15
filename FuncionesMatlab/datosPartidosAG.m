function [pred,res]=datosPartidosAG(liga,par)
[ptas,pathAG]=encontrarPaths;

%liga='Espana';



    switch liga
        case 'Espana'
            load datosEsp0506_1213_puntos.mat
            teams=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            %load RedNeuronalSptos2
            load RedNeuronalSPDir
            s=[ptas{1},'SPFixture1213.xlsx'];
%             s=[ptas{1},'Jornada' num2str(par) 'Esp.xlsx'];
            dir=['PartidosJ' num2str(par) 'Esp_conNombres3.txt'];
            jornada=['1213' num2str(par)];
        case 'Inglaterra'
            load datosIng0506_1213_puntos.mat
            teams=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalEptos2
            s=[ptas{2},'EPFixture1213.xlsx'];
            %s=[ptas{2},'Jornada34Ing.xlsx'];
            dir='PartidosJ35Ing_conNombres.txt';
            jornada=['1213' num2str(par)];
        case 'Alemania'
            load datosAle0506_1213_puntos.mat
            teams=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalDptos2
            s=[ptas{3},'DPFixture1213.xlsx'];
            %s=[ptas{3},'Jornada31Ale.xlsx'];
            dir='PartidosJ32Ale_conNombres.txt';
            jornada=['1213' num2str(par)];
        case 'Italia'
            load datosIta0506_1213_puntos.mat
            teams=textread([ptas{4} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalIptos2
            s=[ptas{4},'IPFixture1213.xlsx'];
            %s=[ptas{4},'Jornada34Ita.xlsx'];
            dir='PartidosJ35Ita_conNombres.txt';
            jornada=['1213' num2str(par)];
        case 'Francia'
            load datosFra0506_1213_puntos.mat
            teams=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalFptos2
            s=[ptas{5},'FPFixture1213.xlsx'];
            %s=[ptas{5},'Jornada34Fra.xlsx'];
            dir='PartidosJ35Fra_conNombres.txt';
            jornada=['1213' num2str(par)];
    end
    
    [n,t,x]=xlsread(s);
    f=find(cell2mat(x(:,1))==par);
     xsub=x(f,2:end);
    c={Theta1;Theta2;ms};
    pred=cell(size(xsub,1),8);
    xsub(:,3:5)=cell(size(xsub,1),3);
    res=[];
for i=1:size(xsub,1)
    eqlocal=eliminarEspacios(xsub{i,1});
    eqvis=eliminarEspacios(xsub{i,2});
    [p,h]=predecirPartido2(c,datos,teams,eqlocal,eqvis,jornada);
    res=[res;p];
    ap=xsub(i,3:5);
    pred(i,:)=[xsub(i,1),xsub(i,2),num2cell(h),ap];
    
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
end