function [ f ] = Q421_11510478( InputImage, k )
%Q421_11510478 compute full inverse filtering
%  k: nature turbulence constant

g = imread(InputImage);
g = im2double(g);
[M, N] = size(g);
G = fft2(g);    
H = zeros(M,N);
G = fftshift(G);
% compute H
for u = 1:M
    for v = 1:N
        H(u,v) = exp(-k*((u-M/2)^2+(v-N/2)^2)^(5/6));
    end
end
% full inverse filtering
F_bar = G./H;
f = real(ifft2(F_bar));
if nargout == 0
    imshowpair(g,f,'montage');
end
end

