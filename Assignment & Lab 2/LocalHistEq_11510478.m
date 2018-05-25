function [ OutputImage, OutputHist, InputHist ] = LocalHistEq_11510478( InputImage, mSize )
%UNTITLED 此处显示有关此函数的摘要
%InputImage: String, file name
%mSize: integer>0, the local size
%InputHist: array of 256 elements, histogram of input
%OutputHist: array of 256 elements, histogram of output
%OutputImage: matrix, same size of InputImage

im = imread(InputImage);
[m,n] = size(im);
OutputImage = zeros(m,n,'uint8');
InputHist = zeros(1,256);
OutputHist = zeros(1,256);
%run for every pixel
for i = 1:m-mSize
    for j = 1:n-mSize
        %generate local area
        %call function LocalHist to give the value of current pixel
        local = im(i:i+mSize-1, j:j+mSize-1);
        OutputImage(i,j)= LocalHist(local);
    end
end
%calculate input histogram
for i = 1:m
    for j = 1:n
        InputHist(im(i,j)+1) = InputHist(im(i,j)+1)+1;
    end
end
%calculate output histogram
for i = 1:m
    for j = 1:n
        OutputHist(OutputImage(i,j)+1) = OutputHist(OutputImage(i,j)+1)+1;
    end
end
%plot the figure
figure;
subplot(2,2,1);imshow(im);title('input image');
subplot(2,2,2);stem((0:255),InputHist,'Marker','none');title('input histogram');xlim([0,255]);
subplot(2,2,3);imshow(OutputImage);title(sprintf('output image, mSize=%d', mSize));
subplot(2,2,4);stem((0:255),OutputHist,'Marker','none');title(sprintf('output histogram, mSize=%d', mSize));xlim([0,255]);
end

%function to calculate the local pixel intensity
function[ LocalValue ] = LocalHist(local)
%local: the local area, mSize x mSize matrix
LocalHist = zeros(1,256);
[mSize,n] = size(local);
% Calculate local histogram
for x = 1:mSize
    for y = 1:mSize
        LocalHist(local(x,y)+1) = LocalHist(local(x,y)+1)+1;
    end
end
% transformation and probability
s = zeros(1,256);
p = LocalHist/(mSize^2);
% Calculate equalization transformation
for  k = 1:length(s)
    s(k) = round((256-1)*sum(p(1:k)));
end
% Give the output grey scale value using transformation
LocalValue = s(local(1,1)+1);
end