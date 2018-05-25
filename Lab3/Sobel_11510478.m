function [ Sobel, Sobel_H ] = Sobel_11510478( InputImage )
%SOBEL_11510478 execute sobel operator on both spatial 
% and frequency domain
% Sobel: output matrix, spatial domain
% Sobel_H: matrix, frequency domain
% if no output, imshow both Sobel and Sobel_H
im = imread(InputImage);
im = im2double(im);
[m,n] = size(im);
Sobel_H = zeros(m,n);
Sobel = zeros(m,n);

% spatial domain calculation
im_pad = padarray(im,[1,1],0,'both');% zeropadding
for i = 2:m-1
    for j = 2:n-1
        %define the filters
        sobel_filt2 = [-1,0,1;-2,0,2;-1,0,1];
        local = im_pad(i-1:i+1,j-1:j+1);
        Sobel(i,j) = sum(sum(local.*sobel_filt2));
    end
end

for i = 1:size(im_pad,1)
    for j = 1:size(im_pad,2)
        im_pad(i,j) = im_pad(i,j)*(-1)^(i+j);
    end
end
% spectrum calculationx
F_pad = fft2(im_pad);% do fft
%imshow(log(abs(F_pad)),[]);
h = [-1,0,1;-2,0,2;-1,0,1];% sobel filter
h_pad = padarray(h,[299,299],0,'both');% padding filter
h_pad = padarray(h_pad,[1,1],0,'pre');
for i = 1:size(h_pad,1)
    for j = 1:size(h_pad,2)
        h_pad(i,j) = h_pad(i,j)*(-1)^(i+j);
    end
end
H_pad = fft2(h_pad);
H_pad = 1i*imag(H_pad);
for i = 1:size(H_pad,1)
    for j = 1:size(H_pad,2)
        H_pad(i,j) = H_pad(i,j)*(-1)^(i+j);
    end
end
% imshow(imag(H_pad),[]);
Sobel_H = F_pad.*H_pad;
% imshow(log(abs(Sobel_H)),[]);
Sobel_h = real(ifft2(Sobel_H));
for i = 1:size(Sobel_h,1)
    for j = 1:size(Sobel_h,2)
        Sobel_h(i,j) = Sobel_h(i,j)*(-1)^(i+j);
    end
end
if nargout == 0
    figure;imshow(Sobel,[]);title('Spatial domain sobel filter');
    figure;imshow(-1*Sobel_h,[]);title('Frequency domain sobel filter');
end
end

