[ptas,pathAG]=encontrarPaths;
s=[ptas{1},'Jornada31Esp.xlsx'];
liga='Espana';
jornada='121331';

[n,t,x]=xlsread(s);
    switch liga
        case 'Espana'
            load datosEsp0506_1213.mat
            teams=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalSEDIF2
        case 'Inglaterra'
            load datosIng0506_1213.mat
            teams=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalSEDIF
        case 'Alemania'
            load datosAle0506_1213.mat
            teams=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalSEDIF
        case 'Italia'
            load datosIta0506_1213.mat
            teams=textread([ptas{4} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalSEDIF
        case 'Francia'
            load datosFra0506_1213.mat
            teams=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            load RedNeuronalSEDIF
    end
    c={Theta1;Theta2;ms};
pred=zeros(size(x,1),6);

for i=1:size(x,1)
    [p,h]=predecirPartido(c,datos,teams,eliminarEspacios(x{i,1}),eliminarEspacios(x{i,2}),jornada);
    ap=x(i,3:5);
    pred(i,:)=[h,cell2mat(ap)];
    
end

 fid = fopen([pathAG,'PartidosJ31Espp.txt'], 'wt');
fprintf(fid, [repmat('%g\t', 1, size(pred,2)-1) '%g\n'], roundn(pred,-4).');
fclose(fid);