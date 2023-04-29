[a,R]=geotiffread('F:\SMC_V3.0\std_anlisyt\annual\x\FP_FVC_2013.8_class.tif_clp.tif');%先导入某个图像的投影信息，为后续图像输出做准确
info=geotiffinfo('F:\SMC_V3.0\std_anlisyt\annual\x\FP_FVC_2013.8_class.tif_clp.tif');
[m,n]=size(a);
years=8; %表示有多少年份需要做回归
data=zeros(m*n,years);
k=1;
for year=2013:2020 %起始年份
    %file=['D:\日降水插值\年prec',int2str(year),'.tif'];%注意自己的名字形式，这里使用的名字是年prec2000.tif，根据这个可修改
     file=strcat('F:\yz\FVC-time\2013-2020-FVC-time\Re-FVC-time\FVC_farm_perfect-clip\','FP_FVC_',int2str(year),'.8_class.tif_clp.tif');
    bz=importdata(file);
    bz=reshape(bz,m*n,1);
    data(:,k)=bz;
    k=k+1;
end
    xielv=zeros(m,n);p=zeros(m,n);
for i=1:length(data)
    bz=data(i,:);
    if max(bz)>0 %注意这是进行判断有效值范围，如果有效范围是-1到1，则改成max(bz)>-1即可
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
%一般来说，只有通过显著性检验的趋势值才是可靠的
