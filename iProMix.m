function img = iProMix(image,num )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
%   ����ͼ�����ȡ
if nargin==1
    divide=8;
elseif nargin==2
    divide=num;
end
imdata=DCT2Part(image,divide);%�������ص�ͼƬ�ֳ�С�飬����ÿ��С����һ�����������б���
temp=zeros(length(imdata),1);%������ȡͼƬ�ڴ�ռ䣬���С�������ͼƬά�����
for i=1:length(imdata)
    mat=dct2(col2mat2(imdata(:,i),[divide divide]));
    %��С����DCT�任�����롮��Ϣ�����͡���������������ÿ��С��ġ�������������ȡ��һ�����ص�
    temp(i)=mat(divide,divide)*255;%��ÿһ�����ص�������һ����������һ����������
end
imsize=[length(image)/divide length(image)/divide];%������ȡͼƬ�ڴ�ռ䣬���С�������ͼƬ�ߴ����
img=col2mat2(temp,imsize);%����������ԭ��һ����Ƭ�������Ϣ����ȡ
end

