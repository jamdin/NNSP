ptas=encontrarPaths;

% load RedNeuronalSPLocal3
% c1={Theta1;Theta2;ms};
% load RedNeuronalSPVisitante3
% c2={Theta1;Theta2;ms};
% load RedNeuronalSPDirecto3
% c3={Theta1;Theta2;ms};
% load RedNeuronalSPUnion3
% c4={Theta1;Theta2;ms};

load RedNeuronalSptos2
c={Theta1;Theta2;ms};

load datosEsp0506_1213_puntos
teams=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
[a,b,x]=xlsread([ptas{1},'SP_1_35.xlsx']);

res=cell2mat(x(:,end));
resul=[];
pred=cell(size(x,1),5);
for i=1:size(x,1)
    eqlocal=eliminarEspacios(x{i,3});
    eqvis=eliminarEspacios(x{i,4});
    jornadaLocal=x{i,1};
    jornadaVis=x{i,2};
    %[p,h]=predecirPartidoPrueba(c1,c2,c3,c4,datos,teams,eqlocal,eqvis,jornadaLocal,jornadaVis);
    [p,h]=predecirPartido(c,datos,teams,eqlocal,eqvis,['1213',num2str(jornadaLocal)]);
    resul=[resul;p];
    pred(i,:)=[x(i,3),x(i,4),num2cell(h)];
        
end

mean(double(res==resul))