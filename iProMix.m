function img = iProMix(image,num )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
%   隐藏图像的提取
if nargin==1
    divide=8;
elseif nargin==2
    divide=num;
end
imdata=DCT2Part(image,divide);%将已隐藏的图片分成小块，并将每个小块变成一个列向量进行保存
temp=zeros(length(imdata),1);%申请提取图片内存空间，其大小与待隐藏图片维度相等
for i=1:length(imdata)
    mat=dct2(col2mat2(imdata(:,i),[divide divide]));
    %对小块做DCT变换，分离‘信息量’和‘冗余量’，并从每个小块的‘冗余量’上提取出一个像素点
    temp(i)=mat(divide,divide)*255;%对每一个像素点做反归一化，并存入一个列向量中
end
imsize=[length(image)/divide length(image)/divide];%申请提取图片内存空间，其大小与待隐藏图片尺寸相等
img=col2mat2(temp,imsize);%将列向量还原成一张照片，完成信息的提取
end

