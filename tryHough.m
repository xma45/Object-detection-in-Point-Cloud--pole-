clc;
clear;

% Preprocessing before hough transform
im=imread('back.jpg');
im0=rgb2gray(im);
im1=histeq(im0);

sigma=10;
gausFilter = fspecial('gaussian', [5,5], sigma);
im2= imfilter(im1, gausFilter, 'replicate');

im3=edge(im2,'Prewitt',0.05,'vertical');% Using the Prewitt to get the vertical edges
im3=edge(im3,'canny');                  % Using the canny to connect some points to edges
subplot(121), imshow(im3), title('image edge');

% the theta and rho of transformed space
[H,Theta,Rho] = hough(im3,'Theta',-20:0.1:20); %Get the lines which -15<theta<15 from im3 to H
subplot(122), imshow(H,[],'XData',Theta,'YData',Rho,'InitialMagnification','fit'),
title('Hough Space space and peaks'); 
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

% label the top 5 voted intersections in Hough space
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = Theta(P(:,2)); 
y = Rho(P(:,1));
plot(x,y,'*','color','r')


% find lines and plot them
lines = houghlines(im3,Theta,Rho,P,'FillGap',30,'MinLength',100);
figure, imshow(im), hold on

for k = 1:length(lines)
 xy = [lines(k).point1; lines(k).point2]; %Get the start point and end point
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','r');
end
