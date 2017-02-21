function [X,y]=jpg2TrainingEx(pic_file_name)

addpath('./zoom');

%%% LOAD JPG into matrix x AND CONVERT IT INTO GRAY SCALE
[img,map,alpha]=imread(pic_file_name);
[x,map]=rgb2ind(img);
x=ind2gray(x,map);
%%% DONE

%%% PROCESS THE x matrix for 0/1 and rotate it 90d
x=single((x>90));
x=(1-(x/max(max(x)) ));
x=rot90(x,-1);
[f,g]=size(x);
%% COMPRESSS THE matrix "x" by 20X and call the result "new"
new=zoom(x,10);

%%CROP the resulting new image
figure(8)
imagesc(new),colorbar,colormap gray

j1=60;
j2=300;
i1=10;
i2=210;

figure(9);
imagesc(new(j1:j2,i1:i2)),colorbar,colormap gray

happy_with_cropping=input("Type 1 and enter if you're happy with the cropping in figure (9), 0 otherwise: ");

while happy_with_cropping==0
	disp("The image x will now be cropped to speed up the process");
	j1=input("Review the image in figure(8) and enter the number of the first raw of pixel that should be kept: ");
	j2=input("Enter the number of the last raw of pixel that should be kept: ");
	i1=input("Enter the number of the most left column of pixel that should be kept: ");
	i2=input("Enter the number of the most right column of pixel that should be kept: ");
	figure(9);
	imagesc(new(j1:j2,i1:i2)),colorbar,colormap gray
	disp(" ");
	happy_with_cropping=input("Type 1 if you're happy with the cropping in figure (9), 0 otherwise: ");
end

if happy_with_cropping==1
	new_cropped=new(j1:j2,i1:i2);
	clear new;
	new=new_cropped;
end

offset_i=20;
offset_j=13;
step_i=21.8;
step_j=22;
step_i_os=-0.08;
step_j_os=-0.04;
number_of_columns=9;
number_of_raws=10;

%disp("The image marking is done assuming character are arranged in the picture as a jxi matris: ");
%disp("The first raw of character is offseted from the top of the picture by offset_i pixels: ");
%offset_i
%disp("The first column of character is offseted from the left of the picture by offset_j pixels: ");
%offset_j
%disp("The distance between columns of character isstep_i pixels: ");
%step_i
%disp("The distance between raws of character is step_j pixels: ");
%step_j
%disp("if the picture is distorted you can adjust for that in the y axis direction with step_i_os: ");
%step_i_os
%disp("if the picture is distorted you can adjust for that in the x axis direction with step_j_os: ");
%step_j_os
%disp("The marking assumes the picture has : ");
%number_of_columns
%disp("The marking assumes the picture has : ");
%number_of_raws

[new_m,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws]=marking_and_visualization(new,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws);

happy_with_marking=0;

happy_with_marking=input("Type 1 if you are happy with the marking in figure (2), type 0 otherwise:");

while happy_with_marking==0;

	offset_i=input("offset_i (from top of picture in pixel): ");
	offset_j=input("offset_j (from left of picture in pixels): ");
	step_j=input("step_j (distance in pixel between columns): ");
	step_i=input("step_i (distance in pixel between raws): ");
	step_j_os=input("step_j_os (distortion in pixel in the x axis direction - spacing between columns will grow from top to bottom if positive): ");
	step_i_os=input("step_i_os (distortion in pixel in the y axis direction - spacing between raws will grow from left to right if positive): ");
	number_of_columns=input("number_of_columns: ");
	number_of_raws=input("number_of_raws: ");

	[new_m,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws]=marking_and_visualization(new,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws);

	happy_with_marking=input("Type 1 if you are happy with the marking in figure (2), type 0 otherwise:");
end

[f,g]=size(new)

clear y;

%y=zeros(1,size(new(:)));
%size(y)

toto=input("The training example generation will start, it might take several minutes, please enter enter 0 to proceed: ");

i=1;

for p=11:f-9
	for q=11:g-9
		y(i)=0;
		if new_m(p,q-1)==1 || new_m(p-1,q-1)==1 || new_m(p+1,q-1)==1 || new_m(p,q)==1 || new_m(p-1,q)==1 || new_m(p+1,q)==1 || new_m(p,q+1)==1 || new_m(p-1,q+1)==1 || new_m(p+1,q+1)==1 
			y(i)=1;
		end
		t=new(p-10:p+9,q-10:q+9);
		X(i,:)=t(:);
		i=i+1;
	end
	p;
	i;
end

y=y';

save X X;
save y y;







