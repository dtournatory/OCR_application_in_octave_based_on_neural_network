function [new,new_m]=crop_n_mark(pic_file_name)

addpath('./zoom');
addpath('./0_Generate_training_examples/croping_marking');
clc

%%% LOAD JPG into matrix x AND CONVERT IT INTO GRAY SCALE
[img,map,alpha]=imread(pic_file_name);
[x,map]=rgb2ind(img);
x=ind2gray(x,map);
%%% DONE

%%% PROCESS THE x matrix for 0/1 and rotate it 90d
x=single((x>90));
x=(x/max(max(x)) );
x=rot90(x,-1);
[f,g]=size(x);

zoom_level=10;
zoom_j_offset=0;
zoom_i_offset=0;
j1=1;
j2=200;
i1=1;
i2=200;
offset_i=1;
offset_j=1;
step_j=20;
step_i=20;
step_j_os=0;
step_i_os=0;
number_of_columns=10;
number_of_raws=10;

use_c_n_m_config=input("Type 1 if you'd like to use an existing zooming, cropping and marking configuration file, type 0 otherwise: ");

happy_with_zoom_level=0;

if use_c_n_m_config==1
	clear cnm_config;
	disp(" ");
 	cnm_config=input("Name of the cropping and marking config file (config file should be located in folder ./0_../croping_marking : ", "s");
	disp(" ");
 	cnm_config=["./0_Generate_training_examples/croping_marking/",cnm_config];
	disp(" ");
	%pwd
	disp(" ");
	
 	load(cnm_config);
 	j1=config_parameters(1);
 	j2=config_parameters(2);
 	i1=config_parameters(3);
 	i2=config_parameters(4);

 	offset_i=config_parameters(5);
 	offset_j=config_parameters(6);
 	step_i=config_parameters(7);
 	step_j=config_parameters(8);
 	step_i_os=config_parameters(9);
 	step_j_os=config_parameters(10);
 	number_of_columns=config_parameters(11);
 	number_of_raws=config_parameters(12);
	zoom_level=config_parameters(13);
	zoom_j_offset=config_parameters(14);
	zoom_i_offset=config_parameters(15);
%%%
%%% ZOOM using parameter from config file:

	clear comperss_X;
	compress_X=zoom(x,int32(zoom_level));
	[k,p]=size(compress_X);
	for i=1:int32(k/20);
		compress_X(i*20-zoom_j_offset,:)=1;
	end
	for i=1:int32(p/20);
		compress_X(:,i*20-zoom_i_offset)=1;
	end
	close all
	figure(1)
	imagesc(compress_X),colorbar,colormap gray

	clc;
	happy_with_zoom_level=1;
	if use_c_n_m_config==0
		happy_with_zoom_level=input("Review figure(1) and type 1 and enter if the zoom and offsets entered are OK, 0 otherwise: ");
	endif
endif

while happy_with_zoom_level==0;
	disp(" ");
	disp("Previous zoom_level used:");
	disp(zoom_level);
	zoom_level=input("Please enter a zoom_level (suggested 10): ");
	disp("Previous vertical offset used:");
	disp(zoom_j_offset);
	zoom_j_offset=input("Please enter a verital offset for the zoom: ");
	disp("Previous horizontal offset used:");
	disp(zoom_i_offset);
	zoom_i_offset=input("Please enter a horizontal offset for the zoom : ");
	clear comperss_X;
	compress_X=zoom(x,int32(zoom_level));
	[k,p]=size(compress_X);
	%% Draw a grid on the picture for visualization
	for i=1:int32(k/20);
		compress_X(i*20-zoom_j_offset,:)=1;
	end
	for i=1:int32(p/20);
		compress_X(:,i*20-zoom_i_offset)=1;
	end
	close all
	figure(1)
	imagesc(compress_X),colorbar,colormap gray
	
	clc;
	happy_with_zoom_level=input("Review figure(1) and type 1 and enter if the offsets entered are putting character on a grid, 0 otherwise: ");
end

clear compress_X;
compress_X=zoom(x,zoom_level);
clear new;
new=compress_X;

clc;

happy_with_cropping=0;

if use_c_n_m_config==1
%	close all
%	figure(1);
%	imagesc(new(j1:j2,i1:i2)),colorbar,colormap gray
%	disp("The image x will now be cropped to speed up the process");
%	happy_with_cropping=input("Type 1 and enter if you're happy with the cropping in figure (1), 0 otherwise: ");
	happy_with_cropping=1;
endif
	
while happy_with_cropping==0
	close all
	figure(1);
	imagesc(new),colorbar,colormap gray
	disp("Previous used number of the first row of pixels kept:");
	disp(j1);
	j1=input("Review figure(1) and enter the number of the first row of pixels that should be kept: ");
	disp("Previous used number of the last row of pixels kept:");
	disp(j2);
	j2=input("Enter the number of the last row of pixel that should be kept: ");
	disp("Previous used number of the most left column of pixels kept:");
	disp(i1);
	i1=input("Enter the number of the most left column of pixel that should be kept: ");
	disp("Previous used number of the most right column of pixels kept:");
	disp(i2);
	i2=input("Enter the number of the most right column of pixel that should be kept: ");
	close all
	close all
	figure(1);
	imagesc(new(j1:j2,i1:i2)),colorbar,colormap gray
	disp(" ");
	happy_with_cropping=input("Type 1 if you're happy with the cropping in figure(1), 0 otherwise: ");
end

new_cropped=new(j1:j2,i1:i2);
clear new;
new=new_cropped;

clc;

happy_with_marking=0;

if use_c_n_m_config==1
 	[new_m,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws]=marking_and_visualization(new,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws,zoom_level,zoom_j_offset,zoom_i_offset);
	clc;
	happy_with_marking=input("Type 1 and enter if marking in figure(1) is OK, type 0 otherwise or if you haven't provided a config file: ");
end

while happy_with_marking==0;
	disp(" ");
	disp(" ");
	disp("We will now ask you to enter marking parameter. This application asumes that all characters in the picture are arranged on a grid");
	disp(" ");
	disp("Previous used offset_i:");
	disp(offset_i);
 	offset_i=input("offset_i (from top of picture in pixel): ");
	disp("Previous used offset_j:");
	disp(offset_j);
 	offset_j=input("offset_j (from left of picture in pixels): ");
	disp("Previous used step_j:");
	disp(step_j);
 	step_j=input("step_j (distance in pixel between columns): ");
	disp("Previous used step_i:");
	disp(step_i);
 	step_i=input("step_i (distance in pixel between raws): ");
	disp("Previous used step_j_os:");
	disp(step_j_os);
 	step_j_os=input("step_j_os (distortion in pixel in the x axis direction - spacing between columns will grow from top to bottom if positive): ");
	disp("Previous used step_i_os:");
	disp(step_i_os);
 	step_i_os=input("step_i_os (distortion in pixel in the y axis direction - spacing between raws will grow from left to right if positive): ");
	disp("Previous used number_of_columns:");
	disp(number_of_columns);
 	number_of_columns=input("number_of_columns: ");
	disp("Previous used number_of_raws:");
	disp(number_of_raws);
 	number_of_raws=input("number_of_raws: ");

 	[new_m,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws]=marking_and_visualization(new,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws);

	clc;
	happy_with_marking=input("Type 1 and enter if marking shown in figure(1) is OK,  0 otherwise or if you haven't provided a config file: ");

end

%new=new_m;

clc;
save_config=0;
%if use_c_n_m_config==0
		save_config=input("Type 1 and enter to save zooming cropping and marking parameters into a file, type 0 otherwise: ");
%endif

if save_config==1;
	clear cnm_config;
		disp(" ");
		disp(" ");
 	cnm_config=input("Enter a file name to save zooming cropping and marking parameters (config file will be located in folder ./0_../croping_marking : ", "s");
 	cnm_config=["./0_Generate_training_examples/croping_marking/",cnm_config];
	clear config_parameters;
	config_parameters=[j1,j2,i1,i2,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws,zoom_level,zoom_j_offset,zoom_i_offset];
	save("-text",cnm_config,"config_parameters");
endif
