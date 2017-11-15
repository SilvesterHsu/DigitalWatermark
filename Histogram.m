function Probability = Histogram( image )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
image=uint8(image);
[height,width]=size(image);
CountPixel=zeros(256,1);  
for row=1:height  
    for col=1:width  
        CountPixel(image(row,col)+1)=CountPixel(image(row,col)+1)+1; 
    end  
end 
Probability=(1/(height*width)).*CountPixel;

end

