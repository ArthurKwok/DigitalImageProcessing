function [ g ] = Gaussian_11510478( input_file, D_0 )
%GAUSSIAN_11510478 此处显示有关此函数的摘要
%   此处显示详细说明
im = imread(input_file);
im = im2double(im);
P = 2*size(im,1);
Q = 2*size(im,2);
im_pad = padarray(im, [P/2,Q/2], 0, 'post');

for i = 1:size(im_pad,1)
    for j = 1:size(im_pad,2)
        im_pad(i,j) = im_pad(i,j)*(-1)^(i+j);
    end
end

F_pad = fft2(im_pad);% do fft
D = zeros(P,Q);
H = zeros(P,Q);
% generate D
for i = floor(P/4):floor(3*P/4)
    for j = floor(Q/4):floor(3*Q/4)
        D(i,j) = sqrt(((i-P/2)^2+(j-Q/2)^2));
    end
end
% generate gaussian filter
H = exp(-D.^2/(2*D_0^2));
% appying filter by multiplying
G = F_pad.*H;
% ifft
g = real(ifft2(G));
% unpadding
g = g(1:size(im,1),1:size(im,2));
for i = 1:size(g,1)
    for j = 1:size(g,2)
        g(i,j) = g(i,j)*(-1)^(i+j);
    end
end
% unshifting
G = G(floor(P/4):floor(3*P/4)-1,floor(Q/4):floor(3*Q/4)-1);
G = log(abs(G));
g = uint8(g);
if nargout == 0
    %figure;imshow(G);title(sprintf('Gaussian filter, D0=%d',D_0));
    %figure;imshow(g);title(sprintf('Output image, D0=%d',D_0));
    imshowpair(G,g,'montage');title(sprintf('Gaussian filter and result, D0=%d', D_0));
end
end

