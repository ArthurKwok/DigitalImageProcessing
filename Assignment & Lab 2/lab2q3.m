% Q3.1
clear;clc;
[oim, oh, ih] = HistEq_11510478('Q2_1_1.tif');
[oim, oh, ih] = HistEq_11510478('Q2_1_2.tif');

%Q3.2
clear;clc
imspec = rgb2gray(imread('Q2_spechist.png'));
spechist = zeros(1,256);
imspec = imresize(imspec, [1000,683]);
[m,n] = size(imspec);
for i = 1:m
    for j = 1:n
        spechist(imspec(i,j)) = spechist(imspec(i,j))+1;
    end
end
spechist = [spechist(50:255), zeros(1,50)];
[oim, oh, ih] = HistMatch_11510478('Q2_2.tif',spechist);


x = [0, 10, 20, 180, 220, 256];
y = [0, 7, 0.5, 0, 0.5, 0];
plot(x,y);

