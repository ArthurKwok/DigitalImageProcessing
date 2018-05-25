function [ I_z ] = Nearest_11510478( input_file, dim )
% an interpolation function that can change the dimension of the input
% image
%   input_file: file name;
%   dim: 1x2 vector, first digit is the row number of the output image,
%   second one the column.

I = imread(input_file);
[row,col] = size(I);
row_z = dim(1);col_z = dim(2);
row_fac = row_z/row; col_fac = col_z/col; %calculate the zoom factor

for i = 1:row_z
    map_i = round(i/row_fac); %calculate the nearest row of j-th row
    for j = 1:col_z 
        map_j = round(j/col_fac); %calculate the nearest column of j-th col
      
        I_z(i,j) = I(map_i,map_j); %map the value of the nearest pixel
    end
end


end

