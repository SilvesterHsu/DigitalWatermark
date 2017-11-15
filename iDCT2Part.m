function temp = iDCT2Part( imdata )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
divide=size(imdata,1)^0.5;
num=size(imdata,2)^0.5;
i=0;
for row=1:num
    for col=1:num
        i=i+1;
        if col==1
            mat=col2mat2(imdata(:,i),[divide divide]);
        else
            mat=[mat col2mat2(imdata(:,i),[divide divide])];
        end
    end
    if row==1
        temp=mat;
    else
        temp=[temp;mat];
    end
end
end

