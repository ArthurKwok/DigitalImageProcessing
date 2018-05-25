
% neareset neighbour
y = Nearest_11510478('rice.tif' ,[461,461]); % 461 = round(256*1.8)
imwrite(y, 'Enlarged_11510478.tif');
y = Nearest_11510478('rice.tif' ,[205,205]); % 205 = round(256*0.8)
imwrite(y, 'Shrinked_11510478.tif');

