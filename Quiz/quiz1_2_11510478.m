function [ OutputImage ] = quiz1_2_11510478( InputImage )
%QUIZ1_2_11510478 此处显示有关此函数的摘要
%   此处显示详细说明
im = imread(InputImage);
im = im2double(im);
[m,n] = size(im);
Laplacian = zeros(m,n);
Sobel = zeros(m,n);

im_pad = padarray(im,[1,1],0,'both');
%figure a-d
for i = 2:m
    for j = 2:n
        % get the local martix
        local = im_pad(i-1:i+1,j-1:j+1);
        laplace_filt = [0,-1,0;-1,4,-1;0,-1,0];
        Laplacian(i,j) = sum(sum(local.*laplace_filt));
        sobel_filt1 = [-1,-2,-1;0,0,0;1,2,1];
        sobel_filt2 = [-1,0,1;-2,0,2;-1,0,1];
        Sobel(i,j) = abs(sum(sum(local.*sobel_filt1)))+abs(sum(sum(local.*sobel_filt2)));
    end
end

figure;imshow(im2uint8(im));title('input image');
figure;imshow(im2uint8(Laplacian+0.5*ones(m,n)));title('laplacian');
figure;imshow(im2uint8(Laplacian+im));title('sharpened by laplacian');
figure;imshow(im2uint8(Sobel));title('Sobel gradient');

% figure e-h
im_pad = padarray(im,[2,2],0,'both');
smoothed_sobel = zeros(m,n);
for i = 3:m
    for j = 3:n
        local = im_pad(i-2:i+2,j-2:j+2);
        smoothed_sobel(i,j) = mean(local(:));
    end
end
masked_sobel = (Laplacian+im).*smoothed_sobel;
sharpened_sobel = im+masked_sobel;
OutputImage = imadjust(sharpened_sobel,[],[],0.5);

figure;imshow(im2uint8(smoothed_sobel));title('sobel image smoothed by 5x5');
figure;imshow(im2uint8(masked_sobel));title('product of sharpened and smoothed sobel');
figure;imshow(im2uint8(sharpened_sobel));title('sum of the input and the product');
figure;imshow(im2uint8(OutputImage));title('adjust gamma value, final output');


end

