function [ OutputImage ] = ReduceSAP_11510478( InputImage, nSize )
%UNTITLED 此处显示有关此函数的摘要
%   nSize: integer>0, must be odd number
im = imread(InputImage);
[m,n] = size(im);
OutputImage = zeros(m,n,'uint8');
%zero padding for InputImage
im = padarray(im,[nSize,nSize],0,'post');
% run for every pixel
for i = 1:m
    for j = 1:n
        % get the local martix
        local = im(i:i+nSize,j:j+nSize);
        % give the value of pixel by the median value of local array
        OutputImage(i,j) = median(local(:));
    end
end
figure;
imshowpair(im,OutputImage,'montage');
end

