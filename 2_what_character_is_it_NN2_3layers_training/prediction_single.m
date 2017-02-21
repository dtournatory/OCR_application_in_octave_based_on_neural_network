function pred=prediction_single(ysss)

load('./2_what_character_is_it_NN2_3layers_training/Theta_NN2/Theta1_NN2.m');
load('./2_what_character_is_it_NN2_3layers_training/Theta_NN2/Theta_NN2.m');

X=ysss(:)';
%%NEXT LINE NORMALIZATION STEP
X=X-mean(X);
sX=size(X);

h1 = 1./(1+exp(-([1 X] * Theta1_NN2')));
h2 = 1./(1+exp(-([1 h1] * Theta_NN2')))
[dummy, p] = max(h2, [], 2);


fprintf('\nPrediction: %f\n', p);

