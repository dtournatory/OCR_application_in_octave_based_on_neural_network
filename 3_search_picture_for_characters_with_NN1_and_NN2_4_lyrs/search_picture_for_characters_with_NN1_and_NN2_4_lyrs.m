clear
addpath('./zoom');

%%% LOAD JPG into matrix x AND CONVERT IT INTO GRAY SCALE

	%%%%%%%%% Check that the file exists if not go back to main menue
file_name=input("Enter picture file name save at the root of this application: ","s");
[dis1, dis2, dis3]=stat(file_name);
if dis2==-1
	toto=input("Sorry this file cannot be found, type any key and enter to return to the main menue: ");
	return
endif
[img,map,alpha]=imread(file_name);

[x,map]=rgb2ind(img);
x=ind2gray(x,map);
%%% DONE

%%% PROCESS THE x matrix and rotate it 90d
x=single((x>90));
%x=(1-(x/max(max(x)) ));
x=rot90(x,-1);
[f,g]=size(x);
%% COMPRESSS THE matrix "x" by 20X and call the result "new"
zoom_level=input("Enter zoom level (10 reduces the image by 10x  both verticaly and horizontaly: ");
new=zoom(x,zoom_level);

%figure(1)
%imagesc(x),colorbar,colormap gray;

figure(2)
imagesc(new),colorbar,colormap gray;


%%load parameters for is it a digit recognition
load('./1_is_it_a_character_NN1_training/Theta_NN1/Theta1_NN1.m');
load('./1_is_it_a_character_NN1_training/Theta_NN1/Theta2_NN1.m');

[f,g]=size(new);

%%load parameters for individual digit recognition
load('./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta1_NN2.m');
load('./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta2_NN2.m');
load('./2_what_character_is_it_NN2_4layers_training/Theta_NN2/Theta3_NN2.m');
load('./2_what_character_is_it_NN2_4layers_training/Theta_NN2/lkup');

k=0;
p=0;
i=1;
j=1;
step=2;

max_h2=0;

while (20+k*step)<f
	while (20+p*step)<g
		%% Step through the picture and check if the current 20x20 pixel is a digit by running the first Neural Network
		t=new(1+k*step:20+k*step,1+p*step:20+p*step);
		Xtemp=t(:)';
		%%NEXT LINE NORMALIZATION STEP
		Xtemp=Xtemp-mean(Xtemp);

		h1 = 1./(1+exp(-([1 Xtemp] * Theta1_NN1')));
		h2 = 1./(1+exp(-([1 h1] * Theta2_NN1')));
		max_h2=max(h2, max_h2);

		%% In anticipation that it is not a digit, the "deco_text" matrix gets assign a "-1" at the corresponding (x,y) position
		deco_text(k+1,p+1)=-1;

		%% if indeed it is a digit, run the second Neural Network to find out which digit it is. Save it in the "deco_text" matrix where the "-1" wa spreviously written
		if h2>0.15
			X(i,:)=t(:);	
				XX=X(i,:);
				h1 = 1./(1+exp(-([1 XX] * Theta1_NN2')));
				h2 = 1./(1+exp(-([1 h1] * Theta2_NN2')));
				h3 = 1./(1+exp(-([1 h2] * Theta3_NN2')));
				[dummy, deco] = max(h3, [], 2);
	%%% Simplification, assumes only digit and correct for digit 0 coded as 10
				deco_text(k+1,p+1)=lkup( find(deco==lkup(:,2)), 1);

			%% Black out the area where the digit was found:
			new(1+k*step:20+k*step,1+p*step:20+p*step)=zeros(20,20);
		end
		p=p+1;
	end


	k=k+1;
	k_jump=0;
	p=0;
end


%% Add rows numbers in the "deco_text" matrix 
[qq,ww]=size(deco_text);

deco_text2=deco_text;
y_pos=-2;
k=1;
while k<qq+1
	if prod(deco_text(k,:)==-1)==1
		deco_text(k,:)=y_pos;
	else
		y_pos=y_pos-1;
		while prod(deco_text(k,:)==-1)~=1 && k<qq
			k=k+1;
		end
	endif
	k=k+1;
end

x_pos=-2;
k=1;

%% Add column numbers in the "deco_text2" matrix 
while k<ww+1
	if prod(deco_text2(:,k)==-1)==1
		deco_text2(:,k)=x_pos;
	else
		x_pos=x_pos-1;
		while prod(deco_text2(:,k)==-1)~=1 && k<ww
			k=k+1;
		end
	endif
	k=k+1;
end

%% Translate the "deco_text" matrix into text format saved in the "decoded_text" matrix. "-1"s become spaces (" ").

clear decoded_text;

done=0;
while done~=2;

	for i=1:qq
		for j=1:ww
			if deco_text(i,j)>-1 
				k=0;
				while deco_text2(i,j+k)>-2 && (j+k)>1
					k=k-1;
				end
				q=0;
				while deco_text(i+q,j)>-2 && (i+q)>1
					q=q-1;
				end
				%-deco_text(i+q,j)
				%-deco_text(i,j+k)
				decoded_text(-deco_text(i+q,j),-deco_text2(i,j+k))=deco_text(i,j);
			endif
			
		end
	end
	if done ==0
		[dj,di]=size(decoded_text);
		decoded_text=-1*ones(dj,di);
	endif
	done=done+1;
end

ligne=[];
text_read=[];
for i=1:dj
	for j=1:di
		if decoded_text(i,j)==-1
			ligne=[ligne [" "]];
		else
			ligne=[ligne, char( decoded_text(i,j) )];
		endif
	end
	text_read=[text_read; ligne];
	ligne=[];
end
%decoded_text
text_read

%save decoded_text decoded_text 

%disp("Figure (1) Shows the original picture processed");
disp("Figure (2) Shows the original picture processed and compressed by 10X");

disp("Figure (3) Shows in black the portion of the image that have been deemed characters");
figure(3)
imagesc(new),colorbar,colormap gray;

