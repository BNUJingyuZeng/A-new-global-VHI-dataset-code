%% �ļ������� ������
clc;clear all;close all;  %��ʼ������
fileFolder='F:\VHI\0.925\'; %��ȡ�ļ�Ŀ¼
dirOutput=dir('F:\VHI\0.925\*.tif');  %�г�ָ��Ŀ¼�º�׺Ϊ.csv .tif .txt�ȵ��ļ�  �����Լ����ļ����ͽ����޸�
%-------------ע��򿪹�����dirOutput  ���ļ���˳�����Լ���Ҫ��˳������
%% 
filename={dirOutput.name}';    
a = 1980
for i=1:41
    oldname = [fileFolder filename{i}];
    a = a+1;%���ơ�0001��Ϊǰ׺��������ʽ���������ε���     
    newname1 = ['VHI_',num2str(a) '.tif'];   %----����ע���޸��ļ���׺
    status = system(['rename "' oldname '" "' newname1 '"']);
%    if status==0
%        disp(['File'  oldname  'file renamed sucessfully'])
%    else
%        disp(['File:' oldname  'file rename failed'])
%    end
end
disp('�������');

