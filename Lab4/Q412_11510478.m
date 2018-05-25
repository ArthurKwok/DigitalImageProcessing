function [ OutputImage ] = Q412_11510478( InputImage, nSize )
%Q412_11510478 use median filter to reduce SAP noise
% simply the same with Q411_11510478.
im = imread(InputImage);
[m,n] = size(im);
OutputImage = zeros(m,n,'uint8');
mSize = (nSize-1)/2;
%zero padding for InputImage
im = padarray(im,[mSize,mSize],0,'both');
% run for every pixel
for i = 1+mSize:1:m+mSize
    for j = 1+mSize:1:n+mSize
        % get the local martix
        local = im(i-mSize:i+mSize, j-mSize:j+mSize);
        % give the value of pixel by the median value of local array
        OutputImage(i,j) = median(local(:));
    end
end
OutputImage = uint8(OutputImage(1+mSize:m+mSize,1+mSize:n+mSize));
if nargout == 0
    imshowpair(imread(InputImage), OutputImage,'montage');
end

end

