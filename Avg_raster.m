function [ data_mean ] = Avg_raster( dz )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明

for i=1:size(dz,1)                                   % 计算文件个数
    filename = strcat('F:\VHI\TCI\',dz(i).name);  % 栅格数据的每个文件地址+文件名
    data = double(importdata(filename));             % 获取栅格数据
    data(data<0) = nan;                              % 将研究区外nodata设为nan值,本例像元值小于0的为NAN    
    data_all{i} = data;                              % 存放于元胞中
    data_mean = mean(cat(3,data_all{:}),3,'omitnan');          % 求元胞内所有矩阵的平均
end



end

