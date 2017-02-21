function pred=prediction_single(ysss)

load('./1_is_it_a_character_NN1_training/Theta_NN1/Theta1_NN1.m');
load('./1_is_it_a_character_NN1_training/Theta_NN1/Theta2_NN1.m');

X=ysss(:)';
X=X-mean(X);
sX=size(X)

h1 = 1./(1+exp(-([1 X] * Theta1_NN1')));
h2 = 1./(1+exp(-([1 h1] * Theta2_NN1')));
[dummy, p] = max(h2, [], 2);


fprintf('\nPrediction: %f\n', p);

