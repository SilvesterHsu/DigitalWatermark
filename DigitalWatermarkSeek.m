%%
tic
%%
clear
cprintf('text','*********************************************\n');
cprintf('text','Load image & key\n');
load('matfile.mat','af_image');
load('bitsize.mat','bitsize');
cprintf('k','bitsize [%d,%d]\n',bitsize(1),bitsize(2));

%%
% 载体分块做DCT变换，分离信息量与冗余量，对2维块矩阵做Z型扫描，存储为bitsize维块向量
cprintf('text','Discrete Cosine Transform...\n');
imdata=matpart2col(af_image,bitsize,'DCT');

pixel=round(imdata(length(imdata(:,1)),1)*255);

if pixel>1
    info_length=ceil(imdata(length(imdata(:,1))-1,1)*255);
else
    info_length=ceil(imdata(length(imdata(:,1)),2)*255);
end
if info_length<0
    cprintf('err','Wrong bitsize!\n');
    return
end
cprintf('k','pixel %d   length %d\n',pixel,info_length);
%%
cprintf('text','Recreate Data Stream...\n');
coldata=zeros(info_length,1);

cprintf('text','Seek data...\n');
t=1;
for i=1:round(info_length/pixel+0.49)
    for j=0:pixel-1
        if t==info_length
            break
        end
        coldata(t,1)=imdata(size(imdata,1)-j,i)*255;
        t=t+1;
    end
end
clear i j t
%%
cprintf('text','Rebuild inserted image...\n')
info_size=[round(coldata(3,1)),round((coldata(2,1)-3)/(coldata(3,1)))];
coldata(1:3,:)=[];
af_info=col2mat2(coldata,info_size);

subplot(247);
imshow(af_info,[]);
title('Extracted image');
subplot(248);
bar(Histogram(af_info));
toc