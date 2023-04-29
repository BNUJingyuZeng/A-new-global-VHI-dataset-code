clc;
clear;
[a,R]=geotiffread('C:\Users\Administrator\Desktop\corrvhi\correlate_vhi1_pdsi.tif'); 
info=geotiffinfo('C:\Users\Administrator\Desktop\corrvhi\correlate_vhi1_pdsi.tif');%����������Ϣ
datasum=zeros(size(a,1)*size(a,2),19);

i = 1;
for m=0.05:0.05:0.95 %ѭ����ȡ�ļ�
    data=importdata(strcat('C:\Users\Administrator\Desktop\corrvhi\correlate_vhi' ,sprintf('%.2f',m), '_pdsi.tif'));%sprintf('%.2f',month)
    %data=importdata(strcat('C:\Users\Administrator\Desktop\corrvhi\correlate_vhi' ,int2str(m), '_pdsi.tif'));%sprintf('%.2f',month)
    data=reshape(data,size(a,1)*size(a,2),1);
    datasum(:,i)=data;
    i = i+1;
end

A = 0.05:0.05:0.95; %�ļ�����Ӧ��ֵ
maxdata=zeros(1,size(a,1)*size(a,2))+NaN;
for n=1:length(datasum)  % ѡȡ���ֵ
    data=datasum(n,:);
    if data>-1   %���ݴ���-1Ϊ��Чֵ
    [x y] = find(data==max(max(data)));
    maxdata(1,n)=A(y(1));  %�����ֵ�ж��ʱѡȡ��һ�����ֵ���ֵ�λ�ø�ֵ %max(y)���һ���ļ���
    else
    maxdata(1,n)=nan;    
    end
end

maxdata=reshape(maxdata,size(a,1),size(a,2));
filename=strcat('C:\Users\Administrator\Desktop\corrvhi\point_mvc.tif');  %������
geotiffwrite(filename,maxdata,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag); 
