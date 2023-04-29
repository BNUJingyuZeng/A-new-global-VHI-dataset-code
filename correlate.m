tic

[a,R]=geotiffread('F:\VHI\VHP.G04.C07.NC.P1981035.VH.VCI.tif');%�ȵ���ͶӰ��Ϣ��ĳ��Ӱ���·�����У������������������е�һ����
info=geotiffinfo('F:\VHI\VHP.G04.C07.NC.P1981035.VH.VCI.tif');%ͬ��
[m,n]=size(a);

VHI=zeros(m*n,40);%�˴�Ҫ�޸ģ����������д���٣���������8���
for year=1981:2020
    filename1=strcat('F:\VHI\0.44\','VHI_',int2str(year),'.tif');%�˴�Ҫ�޸ģ��������ǰ����ÿ�����ֲ�����Ƕȵ����ݣ�ע������ļ����֡�
    data1=double(importdata(filename1));
    data1=reshape(data1,m*n,1);
    VHI(:,year-1980)=data1;%�˴���Ҫ�޸ģ��ҵ������Ǵ�2013��ʼ���˴���Ϊ2012.
end

PDSI=zeros(m*n,40);
for year=1981:2020
    filename2=strcat('F:\VHI\PDSI\','PDSI_',int2str(year),'.tif');%�˴�Ҫ�޸ģ��������ǰ����ÿ������ر��¶ȵ����ݣ�ע������ļ����֡�
    data2=double(importdata(filename2));
    data2=reshape(data2,m*n,1);
    PDSI(:,year-1980)=data2;
end

%����Ժ�������
vhi_pdsi_xgx=zeros(m,n);
vhi_pdsi_p=zeros(m,n);
for i=1:length(VHI)
    VHI1=VHI(i,:);
    if min(VHI1)>0 %ע�������VHI����Ч��Χ�Ǵ���0������Լ���������Ч��Χ��С��0�Ļ�������Բ��ü����
        PDSI1=PDSI(i,:);
         [r2,p2]=corrcoef(VHI1,PDSI1);
         vhi_pdsi_xgx(i)=r2(2);
         vhi_pdsi_p(i)=p2(2);
    end
end

filename5='F:\VHI\0.44\Correlate_VHI_PDSI.tif';%�˴�Ҫ�޸ģ������·��������
filename6='F:\VHI\0.44\Correlate_sig_VHI_PDSI.tif';%ͬ��


%%���ͼ��
geotiffwrite(filename5,vhi_pdsi_xgx,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite(filename6,vhi_pdsi_p,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

sound(sin(2*pi*25*(1:4000)/100));
toc
disp(['����ʱ��: ',num2str(toc)]);