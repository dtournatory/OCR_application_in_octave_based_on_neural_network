clc

%%% The next 6 line check if training examples exists on the disk. If None exit script and return to main menue.
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN2/XNN2_training");
if dis2==-1
	disp("No training examples have been found, please create some from main menue.");
	toto=input("Type 0 and enter to go back to main menue: ");
	return
endif

load('./0_Generate_training_examples/training_ex/NN2/XNN2_training');
load('./0_Generate_training_examples/training_ex/NN2/YNN2_training');
load('./0_Generate_training_examples/stat/XNN2_characters');

input_layer_size  = 400;  % 20x20 Input Images of Digits

happy=0;

while happy==0;

	hidden_layer1_size = input("Enter number of hidden layers 1 (suggested 25): ");  
	hidden_layer2_size = input("Enter number of hidden layers 2 (suggested 25): ");  
	disp(" "); 
	disp(" "); 


	num_labels=0;

	disp(" ");

	clear y_integer;

	clear lkup;
	lkup=zeros(num_labels,2);

	num_labels=1;

	%disp("By convention 0 is called 10, 1 is called 1, ..., 9 is called 9, A is called 11, ...");

	for i=1:length(YNN2_training(:,1))
 		if sum(lkup(:,1)==YNN2_training(i,1))==0  
			lkup(num_labels,1)=YNN2_training(i,1);
			lkup(num_labels,2)=num_labels;
			num_labels=num_labels+1;
		endif
		y_integer(i,1)=lkup(find(YNN2_training(i)==lkup(:,1)),2);
		%%NEXT LINE NORMALIZATION STEP
		XNN2_training(i,:)=XNN2_training(i,:)-mean(XNN2_training(i,:));
	end

	save ./2_what_character_is_it_NN2_4layers_training/Theta_NN2/lkup lkup

	num_labels=num_labels-1;

	Theta1_NN2 = rand(hidden_layer1_size, input_layer_size+1)*2*0.12-0.12;				%% Random initialization 
	Theta2_NN2 = rand(hidden_layer2_size, hidden_layer1_size+1)*2*0.12-0.12;					%% Random initialization 
	Theta3_NN2 = rand(num_labels, hidden_layer2_size+1)*2*0.12-0.12;					%% Random initialization 					%% Random initialization 

	Y=(eye(num_labels)(y_integer,:))';

	disp(" "); 
	lambda=input("Enter the lambda (recomended 2): ");
	disp(" "); 
	max_it=input("Enter the max number of iteration (recomended 1000 or more?): ");
	disp(" "); 
	cost_threshold=input("Enter the cost function threshold (recomended 2.5?): ");
	disp(" "); 
	disp("The cost function will be display in figure (33)");
	disp(" "); 
	toto=input("Calculating parameters Theta1_NN2, Theta2_NN2 and Theta3_NN2. It might take several minutes, type 0 and enter to proceed: ");

	J=10;
	i=1;
	clear cost;
	while i<max_it && J>cost_threshold

		[m,n]=size(XNN2_training);										%% First step of forward propagation
		a1=[ones(m,1) XNN2_training];
		z2=a1*Theta1_NN2';
		[a,b]=size(z2);
		a2=1./(1+exp(-z2));
		a2=[ones(a,1) a2];
		z3=a2*Theta2_NN2';
		a3=1./(1+exp(-z3));
	
		[c,d]=size(a3);
		a3=[ones(c,1) a3];
		z4=a3*Theta3_NN2';
		a4=1./(1+exp(-z4));									%% Last step of forward propagation													%% Cost function
	J(i)=(1/m)*sum(sum(-Y'.*log(a4)-(1-Y)'.*log(1-a4)))+(lambda/(2*m))*(sum(sum((Theta1_NN2(:,2:end)).*(Theta1_NN2(:,2:end))))+sum(sum((Theta2_NN2(:,2:end)).*(Theta2_NN2(:,2:end))))+sum(sum((Theta3_NN2(:,2:end)).*(Theta3_NN2(:,2:end)))));

	delta4=(a4-Y');										%% first step of back propagation
	delta3=(delta4*Theta3_NN2(:,2:end)).*(1./(1+exp(-z3))).*(1-1./(1+exp(-z3)));		%% sigmoid gradient is used
	delta2=(delta3*Theta2_NN2(:,2:end)).*(1./(1+exp(-z2))).*(1-1./(1+exp(-z2)));		%% sigmoid gradient is used

	DELTA1=delta2'*a1;
	DELTA2=delta3'*a2;
	DELTA3=delta4'*a3;

	Theta1_grad = (1/m)*DELTA1;
	Theta2_grad = (1/m)*DELTA2;
	Theta3_grad = (1/m)*DELTA3;

	Theta1T=Theta1_NN2;
	Theta2T=Theta2_NN2;
	Theta3T=Theta3_NN2;

	Theta1T(:,1)=0;										%% We do not regularize the bias term??
	Theta2T(:,1)=0;										%% We do not regularize the bias term??
	Theta3T(:,1)=0;										%% We do not regularize the bias term??

	Theta1T=(lambda/m)*Theta1T;
	Theta2T=(lambda/m)*Theta2T;
	Theta3T=(lambda/m)*Theta3T;

	Theta1_grad = Theta1_grad + Theta1T;
	Theta2_grad = Theta2_grad + Theta2T;
	Theta3_grad = Theta3_grad + Theta3T;

	Theta1_NN2 = Theta1_NN2 - 2*Theta1_grad;
	Theta2_NN2 = Theta2_NN2 - 2*Theta2_grad;
	Theta3_NN2 = Theta3_NN2 - 2*Theta3_grad;							%% Last step of back propagation
	i=i+1;
	end

	save ./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta1_NN2.m Theta1_NN2
	save ./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta2_NN2.m Theta2_NN2
	save ./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta3_NN2.m Theta3_NN2
	disp(" ")
	disp(" ")
	disp("final cost:"),disp(J(i-1))
	disp("Number of iteration performed:"),disp(i)
	figure(33);
	plot(J);
	clear happy;
	disp("Figure (33) shows the cost function versus number of iterations. ");
	happy=input("Type 1 and enter to save the parameters, type 0 and enter to try again: ");

end

