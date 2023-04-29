clc;
clear;
[a,R]=geotiffread('C:\Users\Administrator\Desktop\corrvhi\correlate_vhi1_pdsi.tif'); 
info=geotiffinfo('C:\Users\Administrator\Desktop\corrvhi\correlate_vhi1_pdsi.tif');%导入坐标信息
datasum=zeros(size(a,1)*size(a,2),19);

i = 1;
for m=0.05:0.05:0.95 %循环读取文件
    data=importdata(strcat('C:\Users\Administrator\Desktop\corrvhi\correlate_vhi' ,sprintf('%.2f',m), '_pdsi.tif'));%sprintf('%.2f',month)
    %data=importdata(strcat('C:\Users\Administrator\Desktop\corrvhi\correlate_vhi' ,int2str(m), '_pdsi.tif'));%sprintf('%.2f',month)
    data=reshape(data,size(a,1)*size(a,2),1);
    datasum(:,i)=data;
    i = i+1;
end

A = 0.05:0.05:0.95; %文件名对应的值
maxdata=zeros(1,size(a,1)*size(a,2))+NaN;
for n=1:length(datasum)  % 选取最大值
    data=datasum(n,:);
    if data>-1   %数据大于-1为有效值
    [x y] = find(data==max(max(data)));
    maxdata(1,n)=A(y(1));  %当最大值有多个时选取第一个最大值出现的位置赋值 %max(y)最后一个文件名
    else
    maxdata(1,n)=nan;    
    end
end

maxdata=reshape(maxdata,size(a,1),size(a,2));
filename=strcat('C:\Users\Administrator\Desktop\corrvhi\point_mvc.tif');  %结果输出
geotiffwrite(filename,maxdata,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag); 
