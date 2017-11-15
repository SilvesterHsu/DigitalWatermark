function temp = ProMix( image,info,num )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%   载体图像与待嵌入图像的融合
if nargin==2
    divide=8;
elseif nargin==3
    divide=num;
end

imdata=DCT2Part(image,divide);%将载体图片分成小块，并将每个小块变成一个列向量进行保存

for i=1:length(imdata)
    mat=col2mat2(imdata(:,i),[divide divide]);%将列向量恢复成一个小块
    mat=dct2(mat);%对小块做DCT变换
    insert=info(:).*(1/255);%对待隐藏的图像做归一化，并排列成列向量
    mat(divide,divide)=insert(i);%将待隐藏图像的第i个像素点放入小块的冗余量部分
    mat=idct2(mat);%对小块做DCT反变换，完成‘信息量’和‘冗余量’的融合
    imdata(:,i)=mat(:);%将每个小块变成一个列向量进行保存
end

temp=iDCT2Part(imdata);%将所有小块恢复成一张大图，完成信息的隐藏

end

