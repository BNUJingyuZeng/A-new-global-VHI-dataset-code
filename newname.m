%% 文件重命名 并排序
clc;clear all;close all;  %初始化环境
fileFolder='F:\VHI\0.925\'; %读取文件目录
dirOutput=dir('F:\VHI\0.925\*.tif');  %列出指定目录下后缀为.csv .tif .txt等的文件  根据自己的文件类型进行修改
%-------------注意打开工作区dirOutput  将文件名顺序按照自己想要的顺序排列
%% 
filename={dirOutput.name}';    
a = 1980
for i=1:41
    oldname = [fileFolder filename{i}];
    a = a+1;%类似‘0001’为前缀的命名方式，数字依次递增     
    newname1 = ['VHI_',num2str(a) '.tif'];   %----这里注意修改文件后缀
    status = system(['rename "' oldname '" "' newname1 '"']);
%    if status==0
%        disp(['File'  oldname  'file renamed sucessfully'])
%    else
%        disp(['File:' oldname  'file rename failed'])
%    end
end
disp('处理完毕');

