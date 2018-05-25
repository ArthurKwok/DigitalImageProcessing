function [ G, g ] = Butterworth_11510478( input_file )
%BUTTERWORTH_11510478 此处显示有关此函数的摘要
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
%imshow(log(abs(F_pad)),[]);
v = [110, 110, 223, 223]-Q/2;
u = [170, 88, 80, 163]-P/2;
D0 = 20;
n = 4;
H = ones(P,Q);
for k = 1:length(u)
    D_plus = zeros(P,Q);
    D_minus = zeros(P,Q);
    for i = 1:P
        for j = 1:Q
            D_plus(i,j) = sqrt((i-P/2-u(k)).^2+(j-Q/2-v(k)).^2);
            D_minus(i,j) = sqrt((i-P/2+u(k)).^2+(j-Q/2+v(k)).^2);
        end
    end
    Hkp = 1./(1+(D0./D_plus).^(2*n));
    Hkm = 1./(1+(D0./D_minus).^(2*n));
    H = H.*Hkp.*Hkm;
end
G = F_pad.*H;
% imshow(log(abs(G)),[]);
g = real(ifft2(G));
g = g(1:size(im,1),1:size(im,2));
for i = 1:size(g,1)
    for j = 1:size(g,2)
        g(i,j) = g(i,j)*(-1)^(i+j);
    end
end
G = uint8(log(abs(G)));
if nargout == 0
    figure;imshow(G,[]);title('Butterworth notch filtered, frequency domain');
    figure;imshow(g,[]);title('Butterworth notch filtered, spatial domain');
end
end

