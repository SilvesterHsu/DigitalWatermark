function image = colpart2mat( imdata,imagesize,bitsize,char )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
height=imagesize(1);
width=imagesize(2);
i=1;
for row=1:(floor(height/bitsize(1)))
    for col=1:(floor(width/bitsize(2)))
        if col==1
            if char=='IDCT'
                mat=idct2(iZscan(imdata(:,i),bitsize));
            else
                mat=iZscan(imdata(:,i));
            end
        else
            if char=='IDCT'
                mat=[mat idct2(iZscan(imdata(:,i),bitsize))];
            else
                mat=[mat iZscan(imdata(:,i))];
            end
        end
        i=i+1;
    end
    if row==1
        temp=mat;
    else
        temp=[temp;mat];
    end
end
image=temp;
end

