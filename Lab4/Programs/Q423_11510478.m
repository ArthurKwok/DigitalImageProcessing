function [ f ] = Q423_11510478( InputImage, k, K )
%Q423_11510478 compute Wiener filtering
% k: nature turbulence constant
% K: Wiener Filter specified constant

g = imread(InputImage);
g = im2double(g);
[M, N] = size(g);
G = fft2(g);    
H = zeros(M,N);
G = fftshift(G);
F_bar = zeros(M,N);
for u = 1:M
    for v = 1:N
        H(u,v) = exp(-k*((u-M/2)^2+(v-N/2)^2)^(5/6));
        F_bar(u,v) = (abs(H(u,v))^2/(H(u,v)*(abs(H(u,v))^2+K)))*G(u,v);
    end
end

F_bar = fftshift(F_bar);
f = real(ifft2(F_bar));
if nargout == 0
    figure;
    imshowpair(g,f,'montage');
end

end

