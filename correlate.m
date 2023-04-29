tic

[a,R]=geotiffread('F:\VHI\VHP.G04.C07.NC.P1981035.VH.VCI.tif');%先导入投影信息，某个影像的路径就行（最好是你分析的数据中的一个）
info=geotiffinfo('F:\VHI\VHP.G04.C07.NC.P1981035.VH.VCI.tif');%同上
[m,n]=size(a);

VHI=zeros(m*n,40);%此处要修改，共几年就填写多少，我这里是8年的
for year=1981:2020
    filename1=strcat('F:\VHI\0.44\','VHI_',int2str(year),'.tif');%此处要修改，我这里是八年的每年年均植被覆盖度的数据，注意你的文件名字。
    data1=double(importdata(filename1));
    data1=reshape(data1,m*n,1);
    VHI(:,year-1980)=data1;%此处需要修改，我的数据是从2013开始，此处就为2012.
end

PDSI=zeros(m*n,40);
for year=1981:2020
    filename2=strcat('F:\VHI\PDSI\','PDSI_',int2str(year),'.tif');%此处要修改，我这里是八年的每年年均地表温度的数据，注意你的文件名字。
    data2=double(importdata(filename2));
    data2=reshape(data2,m*n,1);
    PDSI(:,year-1980)=data2;
end

%相关性和显著性
vhi_pdsi_xgx=zeros(m,n);
vhi_pdsi_p=zeros(m,n);
for i=1:length(VHI)
    VHI1=VHI(i,:);
    if min(VHI1)>0 %注意这里的VHI的有效范围是大于0，如果自己的数据有效范围有小于0的话，则可以不用加这个
        PDSI1=PDSI(i,:);
         [r2,p2]=corrcoef(VHI1,PDSI1);
         vhi_pdsi_xgx(i)=r2(2);
         vhi_pdsi_p(i)=p2(2);
    end
end

filename5='F:\VHI\0.44\Correlate_VHI_PDSI.tif';%此处要修改，输出的路径及名字
filename6='F:\VHI\0.44\Correlate_sig_VHI_PDSI.tif';%同上


%%输出图像
geotiffwrite(filename5,vhi_pdsi_xgx,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite(filename6,vhi_pdsi_p,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

sound(sin(2*pi*25*(1:4000)/100));
toc
disp(['运行时间: ',num2str(toc)]);