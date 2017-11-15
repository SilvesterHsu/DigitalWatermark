function temp = ProMix( image,info,num )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%   ����ͼ�����Ƕ��ͼ����ں�
if nargin==2
    divide=8;
elseif nargin==3
    divide=num;
end

imdata=DCT2Part(image,divide);%������ͼƬ�ֳ�С�飬����ÿ��С����һ�����������б���

for i=1:length(imdata)
    mat=col2mat2(imdata(:,i),[divide divide]);%���������ָ���һ��С��
    mat=dct2(mat);%��С����DCT�任
    insert=info(:).*(1/255);%�Դ����ص�ͼ������һ���������г�������
    mat(divide,divide)=insert(i);%��������ͼ��ĵ�i�����ص����С�������������
    mat=idct2(mat);%��С����DCT���任����ɡ���Ϣ�����͡������������ں�
    imdata(:,i)=mat(:);%��ÿ��С����һ�����������б���
end

temp=iDCT2Part(imdata);%������С��ָ���һ�Ŵ�ͼ�������Ϣ������

end

