function a=ImplementarNNfun(Ejemplos,input_layer_size,hidden_layer_size,num_labels,dir)
%%=====================Redes Neuronales=======================
close all;clc;

hidden_layer_units = 1;   %Numero de Capas Ocultas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Leer Datos                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data=Ejemplos(randperm(size(Ejemplos,1)),:);%Reordena los ejemplos aleatoriamente
X = data(:, 1:input_layer_size);
y = data(:, (input_layer_size+1));
% Xp=zeros(size(X));
% for i=1:size(X,1)
%    Xp(i,:)=(X(i,:)-mn)./mx; 
% end
[Xp,ms]=mapminmax(X');
X=Xp';

mtrain=size(X,1)*0.75;
mtrain=round(mtrain);
mcv=size(X,1)*0.25;
mcv=round(mcv);
Xtrain=X(1:mtrain,:);
ytrain=y(1:mtrain,:);
Xcv=X(mtrain+1:end,:);
ycv=y(mtrain+1:end,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Inicializar Thetas                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_nn_params = initial_Theta1(:);
if hidden_layer_units>1
initial_Theta2=randInitializeWeights(hidden_layer_size, hidden_layer_size);
initial_nn_params=[initial_nn_params(:);initial_Theta2(:)];
end
initial_Theta_ultimo = randInitializeWeights(hidden_layer_size, num_labels);

initial_nn_params = [initial_nn_params(:) ; initial_Theta_ultimo(:)];
size(initial_nn_params);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Entrenamiento                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nt1=(1+input_layer_size)*hidden_layer_size;
nt2=nt1+(hidden_layer_size+1)*hidden_layer_size;
options = optimset('MaxIter', 700);
lambda = 1;
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, Xtrain, ytrain, lambda);
if hidden_layer_units>1
costFunction = @(p) nnCostFunction2(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, Xtrain, ytrain, lambda);
end
% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
figure;plot(cost)
if hidden_layer_units>1
Theta1 = reshape(nn_params(1:nt1), ...
                 hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + nt1):nt2), ...
                 hidden_layer_size, (hidden_layer_size + 1)); 
Theta3 = reshape(nn_params((nt2+1):end), ...
                 num_labels, (hidden_layer_size + 1));
else            
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Predecir                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             
%pred = predict2(Theta1, Theta2, Theta3, X);
predcv=predict(Theta1,Theta2,Xcv);
predtr=predict(Theta1,Theta2,Xtrain);
if hidden_layer_units>1
predcv=predict2(Theta1,Theta2,Theta3,Xcv);
predtr=predict2(Theta1,Theta2,Theta3,Xtrain);
end
fprintf('\nTraining Set Accuracy: %f\n', mean(double(predtr == ytrain)) * 100);
fprintf('\nValidation Set Accuracy: %f\n', mean(double(predcv == ycv)) * 100);

[p,hm]=predict(Theta1,Theta2,X);
ymat=zeros(num_labels,size(y,1));
for i=1:size(y,1)
ymat(y(i,1),i)=1;
end

[p,hm2]=predict(Theta1,Theta2,Xcv);
ymat2=zeros(num_labels,size(ycv,1));
for i=1:size(ycv,1)
ymat2(ycv(i,1),i)=1;
end

plotconfusion(ymat,hm');
plotconfusion(ymat2,hm2');


save(dir,'Theta1','Theta2','ms');
a=1;
