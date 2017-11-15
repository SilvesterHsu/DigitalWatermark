function img = DCT2Part( image,num )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if nargin==1
    divide=8;
elseif nargin==2
    divide=num;
end
i=0;
[height,width]=size(image);
img=zeros(divide^2,(height/divide)*(width/divide));
for row=1:height/divide
    for col=1:width/divide
        i=i+1;
        a=image((1+(row-1)*divide):row*divide,(1+(col-1)*divide):col*divide);
        img(:,i)=a(:);
    end
end

end

