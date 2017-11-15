function imdata = matpart2col( image,bitsize,char)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
i=0;
[height,width]=size(image);
temp=floor(height/bitsize(1));
temp=temp*floor(width/bitsize(2));
imdata=zeros(bitsize(1)*bitsize(2),temp);
for row=1:(floor(height/bitsize(1)))
    for col=1:(floor(width/bitsize(2)))
        i=i+1;
        a=image((1+(row-1)*bitsize(1)):row*bitsize(1),(1+(col-1)*bitsize(2)):col*bitsize(2));
        if nargin==2
            imdata(:,i)=a(:);
        elseif nargin==3
            if char=='DCT'
               a=dct2(a);
               data=Zscan(a);
               imdata(:,i)=data;
            end
        end
    end
end

end

