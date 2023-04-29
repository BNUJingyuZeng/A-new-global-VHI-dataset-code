tic
dz = dir('F:\VHI\TCI\*.tif');
% 输?栅格数据地址,读取?件夹下所有tif?件，?个?件代表?个时间（天\16d\?）的数据

% 利?编写的函数
data_mean = Avg_raster(dz);

%% 输出data_mean栅格数据
% 先读取?个已有栅格数据的地理信息
[a,R] = geotiffread('F:\VHI\VHP.G04.C07.NC.P1981035.VH.VCI.tif');
info = geotiffinfo('F:\VHI\VHP.G04.C07.NC.P1981035.VH.VCI.tif');
% 输出带有地理坐标信息的栅格数据
filename = 'F:\VHI\TCI_2021.tif';
geotiffwrite(filename,data_mean,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

sound(sin(2*pi*25*(1:4000)/100));
toc
disp(['运行时间: ',num2str(toc)]);