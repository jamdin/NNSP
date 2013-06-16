ptas=encontrarPaths;

load RedNeuronalSPLocal_gng
c1={Theta1;Theta2;ms};
load RedNeuronalSPVisitante_gng
c2={Theta1;Theta2;ms};
load RedNeuronalSPDirecto_gng
c3={Theta1;Theta2;ms};
load RedNeuronalSPUnion_gng
c4={Theta1;Theta2;ms};

load datosEsp0506_1213_puntos
teams=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
[a,b,x]=xlsread([ptas{1},'SP31_35.xlsx']);

res=cell2mat(x(:,end));
resul=[];
pred=cell(size(x,1),5);
for i=1:size(x,1)
    eqlocal=eliminarEspacios(x{i,3});
    eqvis=eliminarEspacios(x{i,4});
    jornadaLocal=x{i,1};
    jornadaVis=x{i,2};
    [p,h]=predecirPartidoPrueba(c1,c2,c3,c4,datos,teams,eqlocal,eqvis,jornadaLocal,jornadaVis);
    resul=[resul;p];
    pred(i,:)=[x(i,3),x(i,4),num2cell(h)];
        
end
h=cell2mat(pred(:,3:5));
res2=zeros(3,size(res,1));
for i=1:size(res,1)
res2(res(i,1),i)=1;
end
plotconfusion(res2,h');
mean(double(res==resul))