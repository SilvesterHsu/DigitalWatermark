function [num,pixel] = Carryinfor( image ,add )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
rate=0.25;
if nargin==1
    bitnum=4^2;
elseif nargin==2
    bitnum=add(1)*add(2);
end
tol=size(image,1)*size(image,2);
pixel=floor(bitnum^0.5*rate);
num=floor(tol/bitnum)*pixel;
end

