%%
%%
tic
% 加载图片，选择小块(bitsize)大小
clear
close
clc
cprintf('text','*********************************************\n');
% 加载载体图像(image)与待隐藏图像(info)
addr=strcat(char(pwd),'/image.jpg');
image=double(imread(addr));
addr=strcat(char(pwd),'/info.jpg');
info=double(imread(addr));

subplot(241);
imshow(image,[]);
title('Original image');
subplot(242);
bar(Histogram(image));

subplot(243);
imshow(info,[]);
title('Embed image');
subplot(244);
bar(Histogram(info));

scale=[20,20];
[carry,pixel]=Carryinfor(image,scale);
%%
if (length(info(:))+3)>carry
   cprintf('err','Info is too large\n');
   clear
   close
   return
else
    bitsize=scale;
    cprintf('k','bitsize [%d,%d]   pixel %d\n',scale(1),scale(2),pixel);
end

% 生成嵌入数据流：头部＋数据信息，头部为：嵌入像素数＋数据信息校验＋待嵌入图像的高度
cprintf('text','Create Data Stream...\n');
info=[pixel;size(info,1)*size(info,2)+3;size(info,1);info(:)];
info=info/255;
clear addr scale carry
%%
% 载体分块做DCT变换，分离信息量与冗余量，对2维块矩阵做Z型扫描，存储为bitsize维块向量，
% 将嵌入数据流嵌入到载体中的冗余量，嵌入度为0.25每小块
cprintf('text','Discrete Cosine Transform...\n');
imdata=matpart2col(image,bitsize,'DCT');
cprintf('text','Insert Data Stream...\n');
t=1;
for i=1:round(size(info,1)/pixel+0.49)
    for j=0:pixel-1
        if t==size(info,1)
            break
        end
        imdata(size(imdata,1)-j,i)=info(t);
        t=t+1;
    end
end
clear i j t
%%
% 用逆Z型扫描将bitsize维块向量还原成2维块矩阵，对2维块矩阵做IDCT变换，使信息量与冗余量相融合，
% 对融合后的块矩阵做顺序矩阵并运算，生成嵌入后的图像
cprintf('text','Inverse Discrete Cosine Transform...\n');
af_image=colpart2mat(imdata,size(image),bitsize,'IDCT');

if size(af_image,1)<size(image,1)
    af_image=[af_image;image(size(af_image,1)+1:size(image,1),1:size(af_image,2))];
    cprintf('Text','Match row(height)\n');
end
if size(af_image,2)<size(image,2)
    af_image=[af_image image(:,size(af_image,2)+1:size(image,2))];
    cprintf('Text','Match col(width)\n');
end

subplot(245);
imshow(af_image,[]);
title('Result');
subplot(246);
bar(Histogram(af_image));

save('matfile.mat','af_image');
save('bitsize.mat','bitsize');
toc