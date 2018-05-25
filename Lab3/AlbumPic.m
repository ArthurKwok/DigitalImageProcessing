function [ Sobel, Sobel_H ] = Sobel_11510478( InputImage )
%SOBEL_11510478 此处显示有关此函数的摘要
%   此处显示详细说明
im = imread(InputImage);
im = im2double(im);
[m,n] = size(im);
Sobel_H = zeros(m,n);
Sobel = zeros(m,n);

% spatial domain calculation
im_pad = padarray(im,[1,1],0,'both');% zeropadding
for i = 2:m
    for j = 2:n
        %define the filters
        sobel_filt1 = [-1,-2,-1;0,0,0;1,2,1];
        sobel_filt2 = [-1,0,1;-2,0,2;-1,0,1];
        local = im_pad(i-1:i+1,j-1:j+1);
        Sobel(i,j) = sum(sum(local.*sobel_filt2));
    end
end

% spectrum calculation
F = fft2(im);% do fft
F_pad = padarray(F,[1,1],0,'both');
h = [-1,-2,-1;0,0,0;1,2,1];% sobel filter
h_pad = padarray(h,[299,299],0,'both');% padding filter
h_pad = padarray(h_pad,[1,1],0,'pre');
for i = 1:size(h_pad,1)
    for j = 1:size(h_pad,2)
        h_pad(i,j) = (-1)^(i+j);
    end
end
H_pad = fft2(h_pad);
H_pad = imag(H_pad);
for i = 1:size(H_pad,1)
    for j = 1:size(H_pad,2)
        H_pad(i,j) = (-1)^(i+j);
    end
end
Sobel_H = F_pad.*H_pad;
Sobel_h = real(ifft2(Sobel_H));

imshowpair(Sobel,Sobel_h);
end

