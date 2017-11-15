function full = SizeNormalize( image,length)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[height, width]=size(image);
if nargin==1
    immax=max(height,width);
elseif nargin==2
    immax=length;
end
full=zeros(immax,immax);
for row=1:height
    for col=1:width
        full(row,col)=image(row,col);
    end
end
end

