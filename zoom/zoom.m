function [X_scaled]=zoom(X, zscale)

%%% LOAD JPG into matrix x AND CONVERT IT INTO GRAY SCALE
%[img,map,alpha]=imread("../picture.jpg");
%[x,map]=rgb2ind(img);
%x=ind2gray(x,map);
%x=single((x>90));
%x=(1-(x/max(max(x)) ));
%X=rot90(x,-1);

[n,m]=size(X);

%zoomed matrix dimentions
j=double(int16(n/zscale));
i=double(int16(m/zscale));
step_j=double(int16(n/j));
step_i=double(int16(m/i));
j=j-1;
i=i-1;

for k=0:j-1
	X_s(k+1,:)=sum( X(1+k*step_j:(k+1)*step_j,:) ) ;
end

for p=0:i-1
	X_s(:,p+1)=sum( (X_s(:,1+p*step_i:(p+1)*step_i))' )';
end	
%%end of zoom

%%Rescale for a [0,1] min max
X_s=(1-(X_s/max(max(X_s)) ));

clear X_scaled;
X_scaled=X_s(1:j,1:i);

%figure(3)
%imagesc(X),colorbar,colormap gray;                                             

%figure(4)
%imagesc(X_scaled(1:j,1:i)),colorbar,colormap gray;









