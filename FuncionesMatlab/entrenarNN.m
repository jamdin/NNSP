hidden_layer_size=30;
num_labels=3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Inglaterra                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load EjemplosFPDividido

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Local
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ej=Ejlocal;
Ej(Ej(:,end)==3,end)=2;
dirFPloc='RedNeuronalFPLocal_gng';
a=ImplementarNNfun(Ej,size(Ej,2)-1,hidden_layer_size,2,dirFPloc);
load(dirFPloc);
[res,predLocal]=predict(Theta1,Theta2,mapminmax('apply',Ejlocal(:,1:28)',ms)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Visitante
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ej=Ejvisit;
Ej(Ej(:,end)==3,end)=2;
dirFPvis='RedNeuronalFPVisitante_gng';
a=ImplementarNNfun(Ej,size(Ej,2)-1,hidden_layer_size,2,dirFPvis);
load(dirFPvis);
[res,predVis]=predict(Theta1,Theta2,mapminmax('apply',Ejvisit(:,1:28)',ms)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Directo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ej=Ejdirect;
dirFPdir='RedNeuronalFPDirecto_gng';
a=ImplementarNNfun(Ej,size(Ej,2)-1,hidden_layer_size,3,dirFPdir);
load(dirFPdir);
[res,predDir]=predict(Theta1,Theta2,mapminmax('apply',Ejdirect(:,1:28)',ms)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Union
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EjUnion=[predLocal,predDir,predVis,Ejlocal(:,29)];
dirFPUnion='RedNeuronalFPUnion_gng';
a=ImplementarNNfun(EjUnion,size(EjUnion,2)-1,hidden_layer_size,3,dirFPUnion);



