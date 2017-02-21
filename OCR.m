addpath('./0_Generate_training_examples');
addpath('./0_Generate_training_examples/croping_marking');
addpath('./1_is_it_a_character_NN1_training');
addpath('./2_what_character_is_it_NN2_3layers_training');
addpath('./2_what_character_is_it_NN2_4layers_training');
addpath('./3_search_picture_for_characters_with_NN1_and_NN2');
addpath('./3_search_picture_for_characters_with_NN1_and_NN2_4_lyrs');

clc
choice=0;
while choice~=9
	disp(" ");
	clear text_to_be_displayed;
	text_to_be_displayed=["	Neural Network OCR Octave Application v0.1";" ";"	Three neural networks are used in this application.";"	All three networks are training using gradient descent.";"	NN1 (3 layer) finds if a 20x20 pixels picture has a character.";"	NN2 returns the character displayed in a 20x20 pixels image.";"	NN2 has two flavors: a (3 layers) and (4 layers neural) network.";" ";"	The training examples for NN1 are stored in:";"	./0_Generate_training_examples/training_ex/NN1/";"	The training examples for NN2 are stored in:";"	./0_Generate_training_examples/training_ex/NN2/";" ";"	The Theta values for NN1 are stored in:";"	./1_is_it_a_character_NN1_training/Theta_NN1/";"	The Theta of NN2 3 layers flavor are stored in:";"	./2_what_character_is_it_NN2_3layers_training/Theta_NN2/";"	The Thetas of NN2 4 layers flavor are stored in: ";"	./2_what_character_is_it_NN2_4layers_training/Theta_NN2";" ";"	Please choose an option:";" ";"0/ Generate training examples";" ";"1/ Train NN1 to recognize if a 20x20 pixels picture is a character";"2/ Evaluate the accuracy on NN1 on training set";" ";"3/ Train a 3 layers NN2 to recognize wich character is in the 20x20 pixels picture";"4/ Evaluate accuracy of the 3 layers NN2 on training set";" ";"5/ Train a 4 layers NN2 to recognize wich character is in the 20x20 pixels picture";"6/ Evaluate accuracy of the 4 layers NN2 on training set";" ";"7/ Search and display characters in any size picture using NN1 and NN2 3layers";"8/ Search and display characters in any size picture using NN1 and NN2 4layers";" ";"9/ Exit"; " "];
	disp(text_to_be_displayed);
	choice=input("	your option: ");
	if choice==0
		Generate_TE
		choice=0;
	elseif choice==1
		backProp_is_it_a_character_NN1_training
		choice=1;
	elseif choice==2
		prediction_is_a_number_NN1
		choice=2;
	elseif choice==3
		backprop_what_character_is_it_NN2_3layers_training
		choice=3;
	elseif choice==4
		prediction_which_character_NN2
		choice=4;
	elseif choice==5
		backprop_what_character_is_it_NN2_4layers_training
		choice=5;
	elseif choice==6
		prediction_which_character_NN2_4_lyrs
		choice=6;
	elseif choice==7
		search_picture_for_characters_with_NN1_and_NN2
		choice=7;
	elseif choice==8
		search_picture_for_characters_with_NN1_and_NN2_4_lyrs
		choice=8;
	endif
end

