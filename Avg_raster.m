function [ data_mean ] = Avg_raster( dz )
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

for i=1:size(dz,1)                                   % �����ļ�����
    filename = strcat('F:\VHI\TCI\',dz(i).name);  % դ�����ݵ�ÿ���ļ���ַ+�ļ���
    data = double(importdata(filename));             % ��ȡդ������
    data(data<0) = nan;                              % ���о�����nodata��Ϊnanֵ,������ԪֵС��0��ΪNAN    
    data_all{i} = data;                              % �����Ԫ����
    data_mean = mean(cat(3,data_all{:}),3,'omitnan');          % ��Ԫ�������о����ƽ��
end



end

