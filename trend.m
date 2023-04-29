[a,R]=geotiffread('F:\SMC_V3.0\std_anlisyt\annual\x\FP_FVC_2013.8_class.tif_clp.tif');%�ȵ���ĳ��ͼ���ͶӰ��Ϣ��Ϊ����ͼ�������׼ȷ
info=geotiffinfo('F:\SMC_V3.0\std_anlisyt\annual\x\FP_FVC_2013.8_class.tif_clp.tif');
[m,n]=size(a);
years=8; %��ʾ�ж��������Ҫ���ع�
data=zeros(m*n,years);
k=1;
for year=2013:2020 %��ʼ���
    %file=['D:\�ս�ˮ��ֵ\��prec',int2str(year),'.tif'];%ע���Լ���������ʽ������ʹ�õ���������prec2000.tif������������޸�
     file=strcat('F:\yz\FVC-time\2013-2020-FVC-time\Re-FVC-time\FVC_farm_perfect-clip\','FP_FVC_',int2str(year),'.8_class.tif_clp.tif');
    bz=importdata(file);
    bz=reshape(bz,m*n,1);
    data(:,k)=bz;
    k=k+1;
end
    xielv=zeros(m,n);p=zeros(m,n);
for i=1:length(data)
    bz=data(i,:);
    if max(bz)>0 %ע�����ǽ����ж���Чֵ��Χ�������Ч��Χ��-1��1����ĳ�max(bz)>-1����
        bz=bz';
        X=[ones(size(bz)) bz];
        X(:,2)=[1:years]';
        [b,bint,r,rint,stats] = regress(bz,X);
        pz=stats(3);
        p(i)=pz;
        xielv(i)=b(2);
    end
end
name1='F:\yz\YZ-Date\process\Perfect_FVC\sensonal\slope\summer_slope.tif';
name2='F:\yz\YZ-Date\process\Perfect_FVC\sensonal\slope\summer_P.tif';
geotiffwrite(name1,xielv,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite(name2,p,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
%һ����˵��ֻ��ͨ�������Լ��������ֵ���ǿɿ���
