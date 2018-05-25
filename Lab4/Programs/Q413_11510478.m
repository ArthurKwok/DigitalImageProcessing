function [ f ] = Q413_11510478( InputImage, Smax )
%Q413_11510478 Adaptive median filter
g = imread(InputImage);
if (Smax <= 1) || (Smax/2 == round(Smax/2)) || (Smax ~= round(Smax))
   error('SMAX must be an odd integer > 1.')
end
[M, N] = size(g);

% Initial setup.
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
% 
% f = [f;f(M-4:M,:)]; % x array pad
% f = [f,f(:,N-4:N)]; % y array pad
% for i = 1:M
%     for j = 1:N
%         % get the local martix
%         local = f(i:i+4, j:j+4);
%         % give the value of pixel by the median value of local array
%         f(i,j) = prod(local(:))^(1/25);
%     end
% end
f = f(1:1:M, 1:1:N);
if nargout == 0
    imshowpair(g,f,'montage');
end


end

