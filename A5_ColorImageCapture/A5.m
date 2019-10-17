%% Image Procurement
red = imread('C:\Users\AndreaRica\Documents\Andy\AP 187\A5\red.jpg');
green = imread('C:\Users\AndreaRica\Documents\Andy\AP 187\A5\green.jpg');
blue = imread('C:\Users\AndreaRica\Documents\Andy\AP 187\A5\blue.jpg');

red = rgb2gray(red);
green = rgb2gray(green);
blue = rgb2gray(blue);

image = cat(3, red, green, blue);
figure(1); imshow(image);
saveas(1,'Concatenated.png');
%% White Patch Algorithm
%% 
whitep = imread('C:\Users\AndreaRica\Documents\Andy\AP 187\A5\white_patch.png');

red = double(red);
green = double(green);
blue = double(blue);

redw = double(whitep(:,:,1));
greenw = double(whitep(:,:,2));
bluew = double(whitep(:,:,3));

rw = mean(redw,'all');
gw = mean(greenw,'all');
bw = mean(bluew,'all');

new_r = (red)/(rw);
new_g = (green)/(gw);
new_b = (blue)/(bw);

%% All channels
final = cat(3, new_r, new_g, new_b);
figure(3); imshow(final);
saveas(3,'Processed.png');

