clear
clc

load('./0_Generate_training_examples/training_ex/NN2/XNN2_training');
load('./0_Generate_training_examples/training_ex/NN2/YNN2_training');

%%NEXT 3 LINE NORMALIZATION STEP
for i=1:length(XNN2_training(:,1))	
	XNN2_training(i,:)=XNN2_training(i,:)-mean(XNN2_training(i,:));
end

load('./0_Generate_training_examples/training_ex/NN2/XNN2_cross_val');
load('./0_Generate_training_examples/training_ex/NN2/YNN2_cross_val');

%%NEXT 3 LINE NORMALIZATION STEP
for i=1:length(XNN2_cross_val(:,1))	
	XNN2_cross_val(i,:)=XNN2_cross_val(i,:)-mean(XNN2_cross_val(i,:));
end

load('./0_Generate_training_examples/training_ex/NN2/XNN2_test_set');
load('./0_Generate_training_examples/training_ex/NN2/YNN2_test_set');

%%NEXT 3 LINE NORMALIZATION STEP
for i=1:length(XNN2_test_set(:,1))	
	XNN2_test_set(i,:)=XNN2_test_set(i,:)-mean(XNN2_test_set(i,:));
end

load('./0_Generate_training_examples/stat/XNN2_characters');

load('./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta1_NN2.m');
load('./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta2_NN2.m');
load('./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta3_NN2.m');
load('./2_what_character_is_it_NN2_4layers_training/Theta_NN2/lkup');


%%%%%%%%%%%%%% Training examples

clear X;
X=XNN2_training;

clear y;
y=YNN2_training;

m = size(X, 1);

h1 = 1./(1+exp(-([ones(m, 1) X] * Theta1_NN2')));
h2 = 1./(1+exp(-([ones(m, 1) h1] * Theta2_NN2')));
h3 = 1./(1+exp(-([ones(m, 1) h2] * Theta3_NN2')));

[dummy, p] = max(h3, [], 2);

num_labels=1;

length(y(:,1));
[siy,sjy]=size(y);

	clear y_integer;

	num_labels=1;

	for i=1:length(y(:,1))
		y_integer(i,1)=lkup(find(y(i)==lkup(:,1)),2);
	end

fprintf('\nNN2 4 layers accuracy on TRAINING SET: %f\n', mean(double(p == y_integer)) * 100);

	disp(" ");

%%%%%%%%%%%%%%%%%% Cross validation

clear X;
X=XNN2_cross_val;

clear y;
y=YNN2_cross_val;

m = size(X, 1);

h1 = 1./(1+exp(-([ones(m, 1) X] * Theta1_NN2')));
h2 = 1./(1+exp(-([ones(m, 1) h1] * Theta2_NN2')));
h3 = 1./(1+exp(-([ones(m, 1) h2] * Theta3_NN2')));

[dummy, p] = max(h3, [], 2);

clear y_integer;

for i=1:length(y(:,1))
	y_integer(i,1)=lkup(find(y(i)==lkup(:,1)),2);
end

fprintf('\nNN2 4 layers accuracy on CROSS VALIDATION set: %f\n', mean(double(p == y_integer)) * 100);

	disp(" ");


%%%%%%%%%%%%%%%%%% Test set

clear X;
X=XNN2_test_set;

clear y;
y=YNN2_test_set;

m = size(X, 1);

h1 = 1./(1+exp(-([ones(m, 1) X] * Theta1_NN2')));
h2 = 1./(1+exp(-([ones(m, 1) h1] * Theta2_NN2')));
h3 = 1./(1+exp(-([ones(m, 1) h2] * Theta3_NN2')));

[dummy, p] = max(h3, [], 2);

clear y_integer;

for i=1:length(y(:,1))
	y_integer(i,1)=lkup(find(y(i)==lkup(:,1)),2);
end

fprintf('\nNN2 4 layers accuracy on TEST SET: %f\n', mean(double(p == y_integer)) * 100);

	disp(" ");
	disp(" ");
	disp(" ");
	disp(" ");

