clc

%%% The next 5 line check if training examples exists on the disk. 
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN1/XNN1_training");
if dis2==-1
	disp("No training examples have been found, please create some from main menue.");
	toto=input("Type 0 and enter to go back to main menue: ");
	return
endif

load('./0_Generate_training_examples/training_ex/NN1/XNN1_training');
load('./0_Generate_training_examples/training_ex/NN1/YNN1_training');


input_layer_size  = 400;  % 20x20 Input Images of Digits

happy=0;

while happy==0;

	hidden_layer_size = input("Enter number of hidden layers (suggested 25): ");  
	disp(" "); 
	disp(" "); 

	num_labels = 1;          % 10 labels, from 1 to 10 

	yl=size(YNN1_training);
	Y=YNN1_training(1:length(XNN1_training(:,1)),:)';

	disp(" "); 
	lambda=input("Enter the lambda (recomended 0.2): ");
	disp(" "); 
	max_it=input("Enter the max number of iteration (recomended 400): ");
	disp(" "); 
	cost_threshold=input("Enter the cost function threshold (recomended 0.04): ");
	disp(" "); 
	toto=input("Calculating parameters Theta1_NN1 and Theta2_NN1. It might take several minutes, type 0 and enter to proceed: ");
	disp(" "); 
	disp(" "); 
	J=10;
	i=0;

	Theta1_NN1 = rand(hidden_layer_size, input_layer_size+1)*2*0.12-0.12;				%% Random initialization 
	Theta2_NN1 = rand(num_labels, hidden_layer_size+1)*2*0.12-0.12;					%% Random initialization 

	%%NEXT 3 LINE NORMALIZATION STEP
	for i=1:length(XNN1_training(:,1))	
		XNN1_training(i,:)=XNN1_training(i,:)-mean(XNN1_training(i,:));
	end

	i=0;
	
	while i<max_it && J>cost_threshold

		[m,n]=size(XNN1_training);										%% First step of forward propagation
		a1=[ones(m,1) XNN1_training];
		z2=a1*Theta1_NN1';
		[a,b]=size(z2);
		a2=1./(1+exp(-z2));
		a2=[ones(a,1) a2];
		z3=a2*Theta2_NN1';
		a3=1./(1+exp(-z3));									%% Last step of forward propagation
												%% Cost function
		J=(1/m)*sum(sum(-Y'.*log(a3)-(1-Y)'.*log(1-a3)))+(lambda/(2*m))*(sum(sum((Theta1_NN1(:,2:end)).*(Theta1_NN1(:,2:end))))+sum(sum((Theta2_NN1(:,2:end)).*(Theta2_NN1(:,2:end)))));

		delta3=(a3-Y');										%% first step of back propagation
		delta2=(delta3*Theta2_NN1(:,2:end)).*(1./(1+exp(-z2))).*(1-1./(1+exp(-z2)));		%% sigmoid gradient is used
		DELTA1=delta2'*a1;
		DELTA2=delta3'*a2;
		Theta1_grad = (1/m)*DELTA1;
		Theta2_grad = (1/m)*DELTA2;
		Theta1T=Theta1_NN1;
		Theta2T=Theta2_NN1;
		Theta1T(:,1)=0;										%% We do not regularize the bias term??
		Theta2T(:,1)=0;										%% We do not regularize the bias term??
		Theta1T=(lambda/m)*Theta1T;
		Theta2T=(lambda/m)*Theta2T;
		Theta1_grad = Theta1_grad + Theta1T;
		Theta2_grad = Theta2_grad + Theta2T;
		Theta1_NN1 = Theta1_NN1 - 2*Theta1_grad;
		Theta2_NN1 = Theta2_NN1 - 2*Theta2_grad;							%% Last step of back propagation
		i=i+1;
		cost(i)=J;
	end
	save ./1_is_it_a_character_NN1_training/Theta_NN1/Theta1_NN1.m Theta1_NN1
	save ./1_is_it_a_character_NN1_training/Theta_NN1/Theta2_NN1.m Theta2_NN1
	disp(" ")
	disp(" ")
	disp("final cost:"), disp(J)
	disp("Number of iteration performed:"), disp(i)
	figure(10)
	plot(cost);
	clear happy;
	disp("Figure (33) shows the cost function versus number of iterations. ");
	happy=input("Type 1 and enter to save the parameters, type 0 and enter to try again: ");

end

