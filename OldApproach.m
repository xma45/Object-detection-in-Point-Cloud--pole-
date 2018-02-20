clc;
clear;
im=imread('back.jpg');
im1=rgb2gray(im);
%Preprocessing to remove noise
sigma=10;
gausFilter = fspecial('gaussian', [5,5], sigma);
im2= imfilter(im1, gausFilter, 'replicate');
im3=edge(im2,'canny');%finding edges 

%Close, Find edges and Open
BW = imdilate(im3,ones(110));   %Dilate
BW2 = imerode(BW,ones(110));    %Rode
BW3 = edge(BW2,'sobel',0.2,'vertical'); %finding edges 
BW4 = imdilate(BW3,ones(20));
BW5 = imerode(BW4,ones(22)); %A bit higher to remove noise

%Plot the edges on the original figure
final=im2double(im);
final(BW5)=1;

subplot(331),imshow(im1);
subplot(332),imshow(im3);
subplot(333),imshow(BW);
subplot(334),imshow(BW2);
subplot(335),imshow(BW3);
subplot(336),imshow(BW4);
subplot(337),imshow(BW5); 
figure,imshow(final); 
