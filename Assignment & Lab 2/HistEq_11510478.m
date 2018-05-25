function [ OutputImage, OutputHist, InputHist ] = HistEq_11510478( InputImage )
%HISTEQ_1150478 do histogram equalization for the input image,
% and calculate their histogram.
im = imread(InputImage);
[m,n] = size(im);
InputHist = zeros(1,256);
OutputHist = zeros(1,256);
OutputImage = zeros(m,n,'uint8');

% Calculate input histogram
for i = 1:m
    for j = 1:n
        InputHist(im(i,j)+1) = InputHist(im(i,j)+1)+1;
    end
end

% transformation and probability
s = zeros(1,256);
p = InputHist/(m*n);
% Calculate equalization transformation 
for  i = 1:length(s)
    s(i) = round((256-1)*sum(p(1:i)));
end

% Give the output grey scale value using transformation
for i = 1:m
    for j = 1:n
        OutputImage(i,j) = uint8(s(im(i,j)+1));
    end
end

% Calculate the output histogram
for i = 1:m
    for j = 1:n
        OutputHist(OutputImage(i,j)+1) = OutputHist(OutputImage(i,j)+1)+1;
    end
end

OutputImage = im2uint8(OutputImage);
im = im2uint8(im);
figure;
plot(s);title('transfer function');
figure;
subplot(2,2,1);imshow(im);title('input image');
subplot(2,2,2);stem((0:255),InputHist,'Marker','none');title('input histogram');xlim([0,255]);
subplot(2,2,3);imshow(OutputImage);title('output image');
subplot(2,2,4);stem((0:255),OutputHist,'Marker','none');title('output histogram');xlim([0,255]);
end

