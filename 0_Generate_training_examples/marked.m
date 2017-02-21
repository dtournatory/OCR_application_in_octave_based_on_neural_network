function [new_m]=marked(new,offset_i,offset_j,step_i,step_j,step_i_os,step_j_os,number_of_columns,number_of_raws)
clc

[f,g]=size(new);
new_m=zeros(f,g);
step_i_default=step_i;

i=0;
j=0;

for i=0:number_of_raws-1
	step_i=step_i_default;
	for j=0:number_of_columns-1
		step_i=step_i+step_i_os;

		int16(offset_i+i*step_i);int16(offset_j+j*step_j);
		(offset_i+i*step_i);(offset_j+j*step_j);
		i;
		j;

		%new_m(int16(offset_i+i*step_i-2),int16(offset_j+j*step_j-2))=1;
		%new_m(int16(offset_i+i*step_i-1),int16(offset_j+j*step_j-2))=1;
		%new_m(int16(offset_i+i*step_i),int16(offset_j+j*step_j-2))=1;
		%new_m(int16(offset_i+i*step_i+1),int16(offset_j+j*step_j-2))=1;
		%new_m(int16(offset_i+i*step_i+2),int16(offset_j+j*step_j-2))=1;

		%new_m(int16(offset_i+i*step_i-2),int16(offset_j+j*step_j-1))=1;
		%new_m(int16(offset_i+i*step_i-1),int16(offset_j+j*step_j-1))=1;
		%new_m(int16(offset_i+i*step_i),int16(offset_j+j*step_j-1))=1;
		%new_m(int16(offset_i+i*step_i+1),int16(offset_j+j*step_j-1))=1;
		%new_m(int16(offset_i+i*step_i+2),int16(offset_j+j*step_j-1))=1;

		%new_m(int16(offset_i+i*step_i-2),int16(offset_j+j*step_j))=1;
		%new_m(int16(offset_i+i*step_i-1),int16(offset_j+j*step_j))=1;
		new_m(int16(offset_i+i*step_i),int16(offset_j+j*step_j))=1;
		%new_m(int16(offset_i+i*step_i+1),int16(offset_j+j*step_j))=1;
		%new_m(int16(offset_i+i*step_i+2),int16(offset_j+j*step_j))=1;

		%new_m(int16(offset_i+i*step_i-2),int16(offset_j+j*step_j+1))=1;
		%new_m(int16(offset_i+i*step_i-1),int16(offset_j+j*step_j+1))=1;
		%new_m(int16(offset_i+i*step_i),int16(offset_j+j*step_j+1))=1;
		%new_m(int16(offset_i+i*step_i+1),int16(offset_j+j*step_j+1))=1;
		%new_m(int16(offset_i+i*step_i+2),int16(offset_j+j*step_j+1))=1;

		%new_m(int16(offset_i+i*step_i-2),int16(offset_j+j*step_j+2))=1;
		%new_m(int16(offset_i+i*step_i-1),int16(offset_j+j*step_j+2))=1;
		%new_m(int16(offset_i+i*step_i),int16(offset_j+j*step_j+2))=1;
		%new_m(int16(offset_i+i*step_i+1),int16(offset_j+j*step_j+2))=1;
		%new_m(int16(offset_i+i*step_i+2),int16(offset_j+j*step_j+2))=1;
	end
	step_j=step_j+step_j_os;
	offset_j=offset_j-step_j_os;
end

