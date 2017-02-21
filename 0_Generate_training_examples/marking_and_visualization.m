function [new_m,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws]=marking_and_visualization(new,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws)

addpath('./0_Generate_training_examples');

	%% Load matrix "new_m" created by the script "marked.m" The matrix "new_m" has dots at locations representing the center of the digits in the matix "new" that will be created below ("new" is a shrunk version of the original image.

	[new_m]=marked(new,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws);

	%% For visualization only, create matrix "new_marked" a copy of the matrix "new" with little circle representing the position of the digits on the "new" matrix. 
	%% At the same time create the training example matrix "X", X being a list line by line of the unrolled 20x20 image. 
	%% Also create the column matrix "y" with labels (1 means it is centerd on a digit, 0 means it is not centered on a digit.

	new_marked=new;

	[f,g]=size(new);

	clear index;

	[index(1,:),index(2,:)]=find(new_m==1);

	index=index';
	
	[number_marked,toto]=size(index);

	for i=1:number_marked
		new_marked(index(i,1),index(i,2))=0;

		new_marked(index(i,1)-1,index(i,2)-1)=1;
		new_marked(index(i,1)-1,index(i,2))=1;
		new_marked(index(i,1)-1,index(i,2)+1)=1;

		new_marked(index(i,1),index(i,2)-1)=1;
		new_marked(index(i,1),index(i,2)+1)=1;

		new_marked(index(i,1)+1,index(i,2)-1)=1;
		new_marked(index(i,1)+1,index(i,2))=1;
		new_marked(index(i,1)+1,index(i,2)+1)=1;
	end
	
	%figure(1)
	%imagesc(new),colorbar,colormap gray;
	close all

	figure(1)
	imagesc(new_marked),colorbar,colormap gray;
