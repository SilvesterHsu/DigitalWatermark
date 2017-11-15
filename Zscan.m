function col = Zscan( mat )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
T=mat;
[height,width]=size(T);
col=zeros(height*width,1);
x=1;y=1;state=1;tol=x+y;aim=1;
i=1;
col(i)=T(x,y);

while x*y~=height*width
    i=i+1;
    if x==y && x+y~=tol
        tol=x+y;
        if state==1%'x->y'
            state=2;%'y->x';
        elseif state==2
            state=1;%'x->y';
        end
        aim=tol-1;
    elseif y>x && x+y~=tol
        tol=x+y;
        %state=2;%'y->x';
        if state==1%'x->y'
            state=2;%'y->x';
        elseif state==2
            state=1;%'x->y';
        end
        aim=x+y-1;
    elseif x>y && x+y~=tol
        tol=x+y;
        %state=1;%'x->y';
        if state==1%'x->y'
            state=2;%'y->x';
        elseif state==2
            state=1;%'x->y';
        end
        aim=x+y-1;
    end
    if state==2%'y->x'
        if x~=aim 
            tol=x+y;
            if x+1>height
                y=y+1;
            else
                y=y-1;
                x=x+1;
            end
        elseif x==aim
            tol=x+y;
            if x+1<=height
                x=x+1;
            else
                y=y+1;
            end
        end
    elseif state==1%'x->y'
        if y~=aim
            tol=x+y;
            if y+1>width
                x=x+1;
            else
                x=x-1;
                y=y+1;
            end
        elseif y==aim
            tol=x+y;
            if y+1<=width
                y=y+1;
            else
                x=x+1;
            end
        end
    end
    col(i)=T(x,y);
end

end


