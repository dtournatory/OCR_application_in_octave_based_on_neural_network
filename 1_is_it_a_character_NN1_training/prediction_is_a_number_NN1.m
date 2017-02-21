clear
clc

load('./0_Generate_training_examples/training_ex/NN1/XNN1_training');
load('./0_Generate_training_examples/training_ex/NN1/YNN1_training');

%%NEXT 3 LINE NORMALIZATION STEP
for i=1:length(XNN1_training(:,1))	
	XNN1_training(i,:)=XNN1_training(i,:)-mean(XNN1_training(i,:));
end

load('./0_Generate_training_examples/training_ex/NN1/XNN1_cross_val');
load('./0_Generate_training_examples/training_ex/NN1/YNN1_cross_val');

%%NEXT 3 LINE NORMALIZATION STEP
for i=1:length(XNN1_cross_val(:,1))	
	XNN1_cross_val(i,:)=XNN1_cross_val(i,:)-mean(XNN1_cross_val(i,:));
end

load('./0_Generate_training_examples/training_ex/NN1/XNN1_test_set');
load('./0_Generate_training_examples/training_ex/NN1/YNN1_test_set');

%%NEXT 3 LINE NORMALIZATION STEP
for i=1:length(XNN1_test_set(:,1))	
	XNN1_test_set(i,:)=XNN1_test_set(i,:)-mean(XNN1_test_set(i,:));
end

load('./1_is_it_a_character_NN1_training/Theta_NN1/Theta1_NN1.m');
load('./1_is_it_a_character_NN1_training/Theta_NN1/Theta2_NN1.m');
		
clear X;
clear y;
X=XNN1_training;
y=YNN1_training;

m = size(X, 1);

h1 = 1./(1+exp(-([ones(m, 1) X] * Theta1_NN1')));
h2 = 1./(1+exp(-([ones(m, 1) h1] * Theta2_NN1')));
Y=(h2>0.45);

fprintf('\nAccuracy of NN1 on TRAINING SET: %f\n', mean(double(Y == y)) * 100);

clear X;
clear y;
X=XNN1_cross_val;
y=YNN1_cross_val;

m = size(X, 1);

h1 = 1./(1+exp(-([ones(m, 1) X] * Theta1_NN1')));
h2 = 1./(1+exp(-([ones(m, 1) h1] * Theta2_NN1')));
Y=(h2>0.45);

fprintf('\nAccuracy of NN1 on CROSS VALIDATION set: %f\n', mean(double(Y == y)) * 100);

clear X;
clear y;
X=XNN1_test_set;
y=YNN1_test_set;

m = size(X, 1);

h1 = 1./(1+exp(-([ones(m, 1) X] * Theta1_NN1')));
h2 = 1./(1+exp(-([ones(m, 1) h1] * Theta2_NN1')));
Y=(h2>0.45);

fprintf('\nAccuracy of NN1 on TEST SET: %f\n', mean(double(Y == y)) * 100);





