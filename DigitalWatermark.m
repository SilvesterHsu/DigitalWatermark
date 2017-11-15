%%
%%
tic
% ����ͼƬ��ѡ��С��(bitsize)��С
clear
close
clc
cprintf('text','*********************************************\n');
% ��������ͼ��(image)�������ͼ��(info)
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

% ����Ƕ����������ͷ����������Ϣ��ͷ��Ϊ��Ƕ����������������ϢУ�飫��Ƕ��ͼ��ĸ߶�
cprintf('text','Create Data Stream...\n');
info=[pixel;size(info,1)*size(info,2)+3;size(info,1);info(:)];
info=info/255;
clear addr scale carry
%%
% ����ֿ���DCT�任��������Ϣ��������������2ά�������Z��ɨ�裬�洢Ϊbitsizeά��������
% ��Ƕ��������Ƕ�뵽�����е���������Ƕ���Ϊ0.25ÿС��
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
% ����Z��ɨ�轫bitsizeά��������ԭ��2ά����󣬶�2ά�������IDCT�任��ʹ��Ϣ�������������ںϣ�
% ���ںϺ�Ŀ������˳��������㣬����Ƕ����ͼ��
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