function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
K=num_labels;         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

a1=[ones(size(X,1),1) X];
z2=a1*Theta1';
a2=sigmoid(z2);
a2=[ones(size(a2,1),1) a2];
z3=a2*Theta2';
a3=sigmoid(z3);
h=a3;
yy=zeros(length(y),K);

for i=1:length(y)
   yy(i,y(i))=1;    
end

Jsr=0;
for k=1:K

Jsr=Jsr+(-1/m)*(yy(:,k)'*log(h(:,k))+(1-yy(:,k))'*log(1-h(:,k)));

end

reg=0;
for k=2:input_layer_size+1
    for j=1:hidden_layer_size
    reg=reg+Theta1(j,k).^2;
    end
end
for k=2:hidden_layer_size+1
    for j=1:num_labels
    reg=reg+Theta2(j,k).^2;
    end
end
J=Jsr+(lambda/(2*m))*reg;

delta3=zeros(m,K);
delta2=zeros(m,hidden_layer_size);
for t=1:m
    a_1=[1 X(t,:)];
    z2=a_1*Theta1';
    a_2=sigmoid(z2);
    a2=[1 a_2];
    z3=a2*Theta2';
    a_3=sigmoid(z3);
    delta3(t,:)=(a_3-yy(t,:));
    z22=[1 z2];
    a=(delta3(t,:)*Theta2).*sigmoidGradient(z22);
    delta2(t,:)=a(2:end);

    Theta2_grad=Theta2_grad+delta3(t,:)'*a2;
    Theta1_grad=Theta1_grad+delta2(t,:)'*a_1;
end
tt1=[zeros(size(Theta1,1),1) Theta1(:,2:end)];
tt2=[zeros(size(Theta2,1),1) Theta2(:,2:end)];
Theta1_grad=Theta1_grad/m+(lambda/m)*tt1;
Theta2_grad=Theta2_grad/m+(lambda/m)*tt2;





% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
