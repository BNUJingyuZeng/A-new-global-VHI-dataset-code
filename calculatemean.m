tic
dz = dir('F:\VHI\TCI\*.tif');
% ��?դ�����ݵ�ַ,��ȡ?����������tif?����?��?������?��ʱ�䣨��\16d\?��������

% ��?��д�ĺ���
data_mean = Avg_raster(dz);

%% ���data_meanդ������
% �ȶ�ȡ?������դ�����ݵĵ�����Ϣ
[a,R] = geotiffread('F:\VHI\VHP.G04.C07.NC.P1981035.VH.VCI.tif');
info = geotiffinfo('F:\VHI\VHP.G04.C07.NC.P1981035.VH.VCI.tif');
% ������е���������Ϣ��դ������
filename = 'F:\VHI\TCI_2021.tif';
geotiffwrite(filename,data_mean,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

sound(sin(2*pi*25*(1:4000)/100));
toc
disp(['����ʱ��: ',num2str(toc)]);