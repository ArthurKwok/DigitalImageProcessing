function [ f ] = Q43_11510478( InputImage, Smax, K)
%Q43_11510478 first uses adaptive mean filter to reduce AWGN,
% then use wiener filter
% k: nature turbulence constant
% K: Wiener Filter specified constant

g = imread(InputImage);
g = im2double(g);
[M, N] = size(g);
f = g;
f(:) = 0;
alreadyProcessed = false(size(g));

% Begin filtering.
for k = 3:2:Smax
   zmin = ordfilt2(g, 1, ones(k, k), 'symmetric');
   zmax = ordfilt2(g, k * k, ones(k, k), 'symmetric');
   zmed = medfilt2(g, [k k], 'symmetric');
   
   processUsingLevelB = (zmed > zmin) & (zmax > zmed) & ...
       ~alreadyProcessed; 
   zB = (g > zmin) & (zmax > g);
   outputZxy  = processUsingLevelB & zB;
   outputZmed = processUsingLevelB & ~zB;
   f(outputZxy) = g(outputZxy);
   f(outputZmed) = zmed(outputZmed);
   
   alreadyProcessed = alreadyProcessed | processUsingLevelB;
   if all(alreadyProcessed(:))
      break;
   end
end
f = f(1:1:M, 1:1:N);

% wiener filtering
G = fft2(f);    
H = zeros(M,N);
G = fftshift(G);
F_bar = zeros(M,N);
a = 0.1;
b = 0.1;
for u = 1:M
    for v = 1:N
        cons = pi*(u*a+v*b);
        H(u,v) = (1/cons)*(sin(cons))*(exp(-1i*cons));  % blurring
        F_bar(u,v) = (abs(H(u,v))^2/(H(u,v)*(abs(H(u,v))^2+K)))*G(u,v);
    end
end

F_bar = fftshift(F_bar);
f = real(ifft2(F_bar));
f = im2uint8(f);
if nargout == 0
    figure;
    imshowpair(g,f,'montage');
end
end

