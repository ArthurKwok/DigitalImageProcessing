function [ OutputImage ] = quiz1_1_11510478( InputImage )
%QUIZ1_11510478 此处显示有关此函数的摘要
%   此处显示详细说明
im = imread(InputImage);
im = im2double(im);
[m,n] = size(im);
Laplacian = zeros(m,n);

%zero padding for InputImage
im_pad = padarray(im,[1,1],0,'both');
% run for every pixel
for i = 2:m
    for j = 2:n
        % get the local martix
        local = im_pad(i-1:i+1,j-1:j+1);
        %local = typecast(local,'int8');
        filter = [0,-1,0;-1,4,-1;0,-1,0];
        %filter = [1,1,1;1,-8,1;1,1,1];
        Laplacian(i,j) = sum(sum(local.*filter));
    end
end

OutputImage = im2uint8(im+Laplacian);
im = im2uint8(im);
Laplacian_sc = Laplacian+0.5*ones(m,n);
Laplacian = im2uint8(Laplacian);
Laplacian_sc = im2uint8(Laplacian_sc);
subplot(2,2,1);imshow(im);title('input image');
subplot(2,2,2);imshow(Laplacian);title('laplacian');
subplot(2,2,3);imshow(Laplacian_sc);title('scaled laplacian');
subplot(2,2,4);imshow(OutputImage);title('output image');

end

