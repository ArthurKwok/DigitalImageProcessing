function [ OutputImage, OutputHist, InputHist ] = HistMatch_11510478( InputImage, SpecHist )
%HISTMATCH implements the histogram matching calculation
im = imread(InputImage);
[m,n] = size(im);
L = 256;
InputHist = zeros(1,L);
s =  zeros(1,L);
G =  zeros(1,L);
G_1 = zeros(1,L);
OutputImage = zeros(m,n,'uint8');
OutputHist = zeros(1,L);

% compute input histogram
for i = 1:m
    for j = 1:n
        InputHist(im(i,j)+1) = InputHist(im(i,j)+1)+1;
    end
end

% Compute input pdf s, and output pdf G
for i = 1:L
    s(i) = round((L-1)/(m*n)*sum(InputHist(1:i)));
    G(i) = round((L-1)/(m*n)*sum(SpecHist(1:i)));
end

% compute the matching relationship, G_1 matches r to z
for i = 1:L
    for j = 1:L
        if s(i) == G(j)
            G_1(i) = j;
        end
    end
    % if there is no matchable value for s(i), use the adjacent value
    if G_1(i) == 0 && i > 1
        G_1(i) = G_1(i-1);
    end
end

% compute the output image, using matching relation
% +1 due to the array starts from 1 in matlab
for i = 1:m
    for j = 1:n
        OutputImage(i,j) = G_1(im(i,j)+1);
    end
end

% compute the output histogram
for i = 1:m
    for j = 1:n
        OutputHist(OutputImage(i,j)+1) = OutputHist(OutputImage(i,j)+1)+1;
    end
end

im = im2uint8(im);
OutputImage = im2uint8(OutputImage);
figure;
subplot(2,2,1);imshow(im);title('input image');
subplot(2,2,2);stem((0:255),InputHist,'Marker','none');title('input histogram');xlim([0,255]);
subplot(2,2,3);imshow(OutputImage);title('output image');
subplot(2,2,4);stem((0:255),OutputHist,'Marker','none');title('output histogram');xlim([0,255]);
end

