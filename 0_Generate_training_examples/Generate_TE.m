clc

addpath('./0_Generate_training_examples/croping_marking');

%%% The next 5 line create an empty file if the XNN1_num_of_train_ex file does not exists. 
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/stat/XNN1_num_of_train_ex");
if dis2==-1
	XNN1_num_of_train_ex =[];
	save ./0_Generate_training_examples/stat/XNN1_num_of_train_ex XNN1_num_of_train_ex;
endif
	load ./0_Generate_training_examples/stat/XNN1_num_of_train_ex

%%% The next 5 line create an empty file if the XNN1_num_of_train_ex file does not exists. 
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/stat/XNN2_num_of_train_ex");
if dis2==-1
	XNN2_num_of_train_ex =[];
	save ./0_Generate_training_examples/stat/XNN2_num_of_train_ex XNN2_num_of_train_ex;
endif
load ./0_Generate_training_examples/stat/XNN2_num_of_train_ex

%%% The next 5 line create an empty file if the XNN1_num_of_train_ex file does not exists. 
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN2/XNN2_characters");
if dis2==-1
	XNN2_characters =[];
	save ./0_Generate_training_examples/training_ex/NN2/XNN2_characters XNN2_characters;
endif
load ./0_Generate_training_examples/training_ex/NN2/XNN2_characters;

%%% The next lines create empty files if the NN files don't exist. 
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN1/XNN1_training");
if dis2==-1
	XNN1_training =[];
	save ./0_Generate_training_examples/training_ex/NN1/XNN1_training XNN1_training;
endif
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN1/XNN1_cross_val");
if dis2==-1
	XNN1_cross_val =[];
	save ./0_Generate_training_examples/training_ex/NN1/XNN1_cross_val XNN1_cross_val;
endif
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN1/XNN1_test_set");
if dis2==-1
	XNN1_test_set =[];
	save ./0_Generate_training_examples/training_ex/NN1/XNN1_test_set XNN1_test_set;
endif

[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN1/YNN1_training");
if dis2==-1
	YNN1_training =[];
	save ./0_Generate_training_examples/training_ex/NN1/YNN1_training YNN1_training;
endif
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN1/YNN1_cross_val");
if dis2==-1
	YNN1_cross_val =[];
	save ./0_Generate_training_examples/training_ex/NN1/YNN1_cross_val YNN1_cross_val;
endif
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN1/YNN1_test_set");
if dis2==-1
	YNN1_test_set =[];
	save ./0_Generate_training_examples/training_ex/NN1/YNN1_test_set YNN1_test_set;
endif

[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN2/XNN2_training");
if dis2==-1
	XNN2_training =[];
	save ./0_Generate_training_examples/training_ex/NN2/XNN2_training XNN2_training;
endif
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN2/XNN2_cross_val");
if dis2==-1
	XNN2_cross_val =[];
	save ./0_Generate_training_examples/training_ex/NN2/XNN2_cross_val XNN2_cross_val;
endif
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN2/XNN2_test_set");
if dis2==-1
	XNN2_test_set =[];
	save ./0_Generate_training_examples/training_ex/NN2/XNN2_test_set XNN2_test_set;
endif

[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN2/YNN2_training");
if dis2==-1
	YNN2_training =[];
	save ./0_Generate_training_examples/training_ex/NN2/YNN2_training YNN2_training;
endif
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN2/YNN2_cross_val");
if dis2==-1
	YNN2_cross_val =[];
	save ./0_Generate_training_examples/training_ex/NN2/YNN2_cross_val YNN2_cross_val;
endif
[dis1, dis2, dis3]=stat("./0_Generate_training_examples/training_ex/NN2/YNN2_test_set");
if dis2==-1
	YNN2_test_set =[];
	save ./0_Generate_training_examples/training_ex/NN2/YNN2_test_set YNN2_test_set;
endif

		
disp("	This section of the application helps you generated training examples.");
disp("	To generate training examples you should provide jpeg pictures with examples.");
disp("	One easy way to get such pictures is to take picture of a computer screen with a text file open.");
disp("	Each text file should contain only one type of character aligned on a grid");
disp("	(example: 3x3 grid or 10x10 grid).");
disp(" ");
disp("	You should save the pictures (Take for example from your cell phone) in the folder:");
disp("	./0_Generate_training_examples/pictures");
disp(" ");
disp("	To speed up the process you can save the parameters");
disp("	used to process the pictures in a config file and then reuse them.");
disp("	The config files are saved and loaded from the folder:");
disp("	./0_Generate_training_examples/croping_marking");
disp(" ");
disp("	Below the application will display the status of the existing training example of the disk:");
disp(" ");
disp("Number of training exampled contained in the matrix XNN1: ");
disp(XNN1_num_of_train_ex);
disp(" ");
disp("Number of training exampled contained in the matrix XNN2: ");
disp(XNN2_num_of_train_ex);
disp(" ");
disp("The XNN2 matrix contains the following characters: ");
disp(XNN2_characters);
disp(" ");
disp(" ");

disp("1. Generate training examples for NN1 (NN1 answers: Is is a character?)");
disp("2. Generate training examples for NN2 (NN2 answers: What character is it?)");
disp("3. Go back to main menue");
disp(" ");
yourchoice=input("	Enter your choice: ");
clc
if yourchoice==1
	clear yourchoice1;
	disp("The new training example can be added to the existing XNN2 training examples. ");
	disp(" ");
	yourchoice1=input("Type 1 and enter to delete existing training example, enter 0 and enter to keep them: ");
	if yourchoice1==1

		clear XNN1_training;
		XNN1_training=[];
		save ./0_Generate_training_examples/training_ex/NN1/XNN1_training XNN1_training
		clear YNN1_training;
		YNN1_training=[];
		save ./0_Generate_training_examples/training_ex/NN1/YNN1_training YNN1_training

		clear XNN1_cross_val;
		XNN1_cross_val=[];
		save ./0_Generate_training_examples/training_ex/NN1/XNN1_cross_val XNN1_cross_val
		clear YNN1_cross_val;
		YNN1_cross_val=[];
		save ./0_Generate_training_examples/training_ex/NN1/YNN1_cross_val YNN1_cross_val

		clear XNN1_test_set;
		XNN1_test_set=[];
		save ./0_Generate_training_examples/training_ex/NN1/XNN1_test_set XNN1_test_set
		clear YNN1_test_set;
		YNN1_test_set=[];
		save ./0_Generate_training_examples/training_ex/NN1/YNN1_test_set YNN1_test_set

		clear XNN1_num_of_train_ex;
		XNN1_num_of_train_ex=[];
		save ./0_Generate_training_examples/stat/XNN1_num_of_train_ex XNN1_num_of_train_ex

		disp(" ");
		disp("NN1 has been cleared from the disk");
	end
	clc;
	clear picture_name;
	picture_name=input("Name of a picture to be used to generate training example (picture should be located in folder ./0_../pictures : ", "s");
	picture_name=["./0_Generate_training_examples/pictures/",picture_name];
	clear new;
	[new,new_m]=crop_n_mark(picture_name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	clear XNN1_temp;
	clear YNN1_temp;
	[f,g]=size(new);
	clear y;

	clc;
	%tot=input("We will now generate the training example, it might take several minutes, type 0 and enter to proceed: ");
	i=1;
	for p=11:f-9
		for q=11:g-9
			YNN1_temp(i)=0;
			if new_m(p,q-1)==1 || new_m(p-1,q-1)==1 || new_m(p+1,q-1)==1 || new_m(p,q)==1 || new_m(p-1,q)==1 || new_m(p+1,q)==1 || new_m(p,q+1)==1 || new_m(p-1,q+1)==1 || new_m(p+1,q+1)==1 
				YNN1_temp(i)=1;
			endif
			t=new(p-10:p+9,q-10:q+9);
			XNN1_temp(i,:)=t(:);
			i=i+1;
		end
		p;
	 	i;
	end
	YNN1_temp=YNN1_temp';
%%%%%%%%%%%%%%%%%%%%%%%%%%
	load ./0_Generate_training_examples/training_ex/NN1/XNN1_training;
	load ./0_Generate_training_examples/training_ex/NN1/XNN1_cross_val;
	load ./0_Generate_training_examples/training_ex/NN1/XNN1_test_set;

	load ./0_Generate_training_examples/training_ex/NN1/YNN1_training;
	load ./0_Generate_training_examples/training_ex/NN1/YNN1_cross_val;
	load ./0_Generate_training_examples/training_ex/NN1/YNN1_test_set;

	XNN1=[XNN1_training;XNN1_cross_val;XNN1_test_set;XNN1_temp];
	YNN1=[YNN1_training;YNN1_cross_val;YNN1_test_set;YNN1_temp];

%%% shuffling of the examples
	[i,j]=size(XNN1);
	[S I]=sort(rand(i,1));
		
	clear XNN1_temp;
	clear YNN1_temp;
	XNN1_temp=XNN1(I,:);
	YNN1_temp=YNN1(I,:);

	tr_nm=int32(i*0.6);
	cv_nb=int32(i*0.2);

	XNN1_training=XNN1_temp(1:tr_nm,:);
	YNN1_training=YNN1_temp(1:tr_nm,:);

	XNN1_cross_val=XNN1_temp(tr_nm+1:tr_nm+cv_nb,:);
	YNN1_cross_val=YNN1_temp(tr_nm+1:tr_nm+cv_nb,:);

	XNN1_test_set=XNN1_temp(1+tr_nm+cv_nb:i,:);
	YNN1_test_set=YNN1_temp(1+tr_nm+cv_nb:i,:);

	%disp(" ");
	size(XNN1_training)
	%size(YNN1_training)
	%disp(" ");
	size(XNN1_cross_val)
	%size(YNN1_cross_val)
	%disp(" ");
	size(XNN1_test_set)
	%size(YNN1_test_set)

	save ./0_Generate_training_examples/training_ex/NN1/XNN1_training XNN1_training;
	save ./0_Generate_training_examples/training_ex/NN1/XNN1_cross_val XNN1_cross_val;
	save ./0_Generate_training_examples/training_ex/NN1/XNN1_test_set XNN1_test_set;

	save ./0_Generate_training_examples/training_ex/NN1/YNN1_training YNN1_training;
	save ./0_Generate_training_examples/training_ex/NN1/YNN1_cross_val YNN1_cross_val;
	save ./0_Generate_training_examples/training_ex/NN1/YNN1_test_set YNN1_test_set;

	[XNN1_num_of_train_ex,dum]=size(XNN1);
	save ./0_Generate_training_examples/stat/XNN1_num_of_train_ex XNN1_num_of_train_ex
	disp(" ");
	disp("Number of training exampled now in the matrix XNN1 (Total inlusing, training set, validation set and test set: ");
	disp(XNN1_num_of_train_ex);
	disp(" ");
	
elseif yourchoice==2
	clear yourchoice1;
	disp("New training example from the provided picture can be added to the existing XNN2 training examples. ");
	disp(" ");
	yourchoice1=input("Type 1 and enter to delete existing training example, type 0 an enter to keep them: ");
	if yourchoice1==1
		clear XNN2_training;
		XNN2_training=[];
		save ./0_Generate_training_examples/training_ex/NN2/XNN2_training XNN2_training
		clear YNN2_training;
		YNN2_training=[];
		save ./0_Generate_training_examples/training_ex/NN2/YNN2_training YNN2_training

		clear XNN2_cross_val;
		XNN2_cross_val=[];
		save ./0_Generate_training_examples/training_ex/NN2/XNN2_cross_val XNN2_cross_val
		clear YNN2_cross_val;
		YNN2_cross_val=[];
		save ./0_Generate_training_examples/training_ex/NN2/YNN2_cross_val YNN2_cross_val

		clear XNN2_test_set;
		XNN2_test_set=[];
		save ./0_Generate_training_examples/training_ex/NN2/XNN2_test_set XNN2_test_set
		clear YNN2_test_set;
		YNN2_test_set=[];
		save ./0_Generate_training_examples/training_ex/NN2/YNN2_test_set YNN2_test_set

		clear XNN2_characters;
		XNN2_characters =[];
		save ./0_Generate_training_examples/training_ex/NN2/XNN2_characters XNN2_characters;

		disp(" ");
		disp("NN2 has been cleared from the disk");
	end
	clear picture_name;

	clc;
	disp("The picture that will be use should contain only one type of charater on a grid");
	clear picture_name;
	disp(" ");
	picture_name=input("Name of a picture to be used (picture should be located in folder ./0_../pictures : ", "s");
	picture_name=["./0_Generate_training_examples/pictures/",picture_name];
	clear character;
	disp(" ");
	disp(" ");
	character=input("Enter the character that is repeated in this picture: ", "s");
	clear new;
	[new,new_m]=crop_n_mark(picture_name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	clear XNN2_temp;
	XNN2_temp=[];
	clear YNN2_temp;
	YNN2_temp=[];
	[f,g]=size(new);
	clear y;
	disp(" ");
	disp(" ");
	toto=input("We will now generate the training example, it might take several minutes, please type any key and enter to proceed: ");
	i=1;
	for p=11:f-9
		for q=11:g-9
			if new_m(p,q-1)==1 || new_m(p-1,q-1)==1 || new_m(p+1,q-1)==1 || new_m(p,q)==1 || new_m(p-1,q)==1 || new_m(p+1,q)==1 || new_m(p,q+1)==1 || new_m(p-1,q+1)==1 || new_m(p+1,q+1)==1 

				YNN2_temp(i)=character;
				t=new(p-10:p+9,q-10:q+9);
				XNN2_temp(i,:)=t(:);
				i=i+1;
			endif
		end
		p;
	 	i;
	end
	YNN2_temp=YNN2_temp';

%%%%%%%%%%%%%%%%%%%%%%%%%%
	load ./0_Generate_training_examples/training_ex/NN2/XNN2_training;
	load ./0_Generate_training_examples/training_ex/NN2/XNN2_cross_val;
	load ./0_Generate_training_examples/training_ex/NN2/XNN2_test_set;

	load ./0_Generate_training_examples/training_ex/NN2/YNN2_training;
	load ./0_Generate_training_examples/training_ex/NN2/YNN2_cross_val;
	load ./0_Generate_training_examples/training_ex/NN2/YNN2_test_set;

	XNN2=[XNN2_training;XNN2_cross_val;XNN2_test_set;XNN2_temp];
	YNN2=[YNN2_training;YNN2_cross_val;YNN2_test_set;YNN2_temp];

%%% shuffling of the examples
	[i,j]=size(XNN2);
	[S I]=sort(rand(i,1));
		
	clear XNN2_temp;
	clear YNN2_temp;
	XNN2_temp=XNN2(I,:);
	YNN2_temp=YNN2(I,:);

	tr_nm=int32(i*0.6);
	cv_nb=int32(i*0.2);

	XNN2_training=XNN2_temp(1:tr_nm,:);
	YNN2_training=YNN2_temp(1:tr_nm,:);

	XNN2_cross_val=XNN2_temp(tr_nm+1:tr_nm+cv_nb,:);
	YNN2_cross_val=YNN2_temp(tr_nm+1:tr_nm+cv_nb,:);

	XNN2_test_set=XNN2_temp(1+tr_nm+cv_nb:i,:);
	YNN2_test_set=YNN2_temp(1+tr_nm+cv_nb:i,:);

	%disp(" ");
	%size(XNN2_training)
	%size(YNN2_training)
	%disp(" ");
	%size(XNN2_cross_val)
	%size(YNN2_cross_val)
	%disp(" ");
	%size(XNN2_test_set)
	%size(YNN2_test_set)

	save ./0_Generate_training_examples/training_ex/NN2/XNN2_training XNN2_training;
	save ./0_Generate_training_examples/training_ex/NN2/XNN2_cross_val XNN2_cross_val;
	save ./0_Generate_training_examples/training_ex/NN2/XNN2_test_set XNN2_test_set;

	save ./0_Generate_training_examples/training_ex/NN2/YNN2_training YNN2_training;
	save ./0_Generate_training_examples/training_ex/NN2/YNN2_cross_val YNN2_cross_val;
	save ./0_Generate_training_examples/training_ex/NN2/YNN2_test_set YNN2_test_set;

	[XNN2_num_of_train_ex,dum]=size(XNN2);
	save ./0_Generate_training_examples/stat/XNN2_num_of_train_ex XNN2_num_of_train_ex
	disp(" ");
	disp("Number of training exampled now in the matrix XNN2: ");
	disp(XNN2_num_of_train_ex);
	disp(" ");

	disp("The XNN2 matrix contains the following characters: ");
	clear XNN2_characters;
	load ./0_Generate_training_examples/training_ex/NN2/XNN2_characters;
	XNN2_characters=[XNN2_characters, character];
	disp(XNN2_characters);
	save ./0_Generate_training_examples/training_ex/NN2/XNN2_characters XNN2_characters;
	disp(" ");
	disp(" ");
endif



