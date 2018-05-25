function [ f ] = Q422_11510478( InputImage, k, d0)
%Q421_11510478 compute radially limited inverse filtering
%  k: nature turbulence constant
% d0: butterworth LPF cutoff frequency

g = imread(InputImage);
g = im2double(g);
[M, N] = size(g);
G = fft2(g);    
H = zeros(M,N);
G = fftshift(G);
% calculate H
for u = 1:M
    for v = 1:N
        H(u,v) = exp(-k*((u-M/2)^2+(v-N/2)^2)^(5/6));
    end
end
% full inverse filtering
F_bar = G./H;
% lowpass filtering
filter=zeros(M,N);
n=10;%Order of butterworth filter
for u=1:M
    for v=1:N
        dist=sqrt((u-M/2)^2 + (v-N/2)^2);
        filter(u,v)= ( 1 + (dist/d0)^(2*n))^(-1);
    end
end
F_bar = F_bar.*filter;
F_bar = fftshift(F_bar);
f = real(ifft2(F_bar));
if nargout == 0
    imshowpair(g,f,'montage');
end
end

