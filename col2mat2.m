function im2 = col2mat2( im1, imsize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t=0;
im2=zeros(imsize(1),imsize(2));
for col=1:imsize(2)
    for row=1:imsize(1)
        t=t+1;
        im2(row,col)=im1(t,1);
    end;
end;

end

