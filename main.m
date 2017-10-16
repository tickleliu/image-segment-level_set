clear all; close all;

imrgb = imread('test.jpg');

u0 = rgb2gray(imrgb);
u0 = double(u0);
activecontourCV( u0, [88,135], 10,0, 100, 0, '' );