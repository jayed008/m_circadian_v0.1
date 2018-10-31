% strFileName=strcat('D:\Data\data_Fi.txt');
% Data=load(strFileName);
clc;clear;
close all;
t=xlsread('Data/data_t.xlsx');
Fi=xlsread('Data/data_Fi.xlsx');
Fj=xlsread('Data/data_Fj.xlsx');
Fm=xlsread('Data/data_Fm.xlsx');
lev = 6;
wname = 'db5';

for l=1:3
    if l==1
        F1=Fi; %选择参数 
    end
    if l==2
        F1=Fm; %选择参数 
    end
    if l==3
        F1=Fj; %选择参数 
    end

for m=1:6  %选择第几个样本，共18个样本
[C,L]=wavedec(F1(m,:),lev,wname);%一维多尺度小波分解
figure;
j=1;                    
for i=1:6
f=strcat('a',num2str(i));
g=strcat('d',num2str(i));           
A(i,:)=wrcoef('a',C,L,wname,i);                 % 重构低频系数
D(i,:)=wrcoef('d',C,L,wname,i);%重建某一次小波系数   重构高频系数

subplot(6,2,j)
plot(t,A(i,:),'b');
ylabel(f);
xlabel('每天的时刻/时');
j=j+1;
set(gca,'XTick',12:12:72);
set(gca,'XTicklabel',{12,24,12,24,12,24});
xlim([12 72])

subplot(6,2,j)
plot(t,D(i,:),'m');
ylabel(g);
xlabel('每天的时刻/时');
j=j+1;
set(gca,'XTick',12:12:72);
set(gca,'XTicklabel',{12,24,12,24,12,24});
xlim([12 72])


end 

    if l==1
        aa='Fi'; %选择参数 
    end
    if l==2
        aa='Fm'; %选择参数 
    end
    if l==3
        aa='Fj'; %选择参数 
    end
    
tt=strcat(num2str(m),'号叶子',aa,'信号小波分解图');
suptitle(tt);


%求取阈值 
sigma = wnoisest(C,L,1);   %使用库函数wnoisest提取第一层的细节系数来估算噪声的标准偏差  
N = numel(F1(m,:));         %整个信号的长度  
thr = sigma*sqrt(2*log(N));%最终阈值  
  
%全局阈值处理  
keepapp = 1;%近似系数不作处理  
F2(m,:) = wdencmp('gbl',C,L,wname,lev,thr,'s',keepapp);  
denoisexh = wdencmp('gbl',C,L,wname,lev,thr,'h',keepapp);  
 
% figure;
% plot(t,F1(m,:),'k:')  
% hold on
% plot(t,F2,'r-')
% legend('Fj-原始信号','Fj-小波去噪后');
% title('Fj信号去噪效果'); 
% subplot(313),  
% plot(denoisexh), title('Hard-threshold Denoised Singal') ; 
end
figure;
for p =1:6

    if p==1
        plot(t,F1(p,:),'k:')
        hold on
        plot(t,F2(p,:),'r-')
    end
    if p==4
        plot(t,F1(p,:),'k-.')
        hold on
        plot(t,F2(p,:),'b-')
    end
    
    if p==5
        plot(t,F1(p,:),'k--')
        hold on
        plot(t,F2(p,:),'m-')
    end
end

    if l==1
        bb='Fi'; %选择参数 
    end
    if l==2
        bb='Fm'; %选择参数 
    end
    if l==3
        bb='Fj'; %选择参数 
    end
ttt = strcat('1,4,5号叶片',bb,'原始信号与小波去噪信号');   
title(ttt);

l1 = strcat('1号',bb,'原始信号');
l2 = strcat('1号',bb,'小波去燥后信号');
l3 = strcat('4号',bb,'原始信号');
l4 = strcat('4号',bb,'小波去燥后信号');
l5 = strcat('5号',bb,'原始信号');
l6 = strcat('5号',bb,'小波去燥后信号');
legend(l1,l2,l3,l4,l5,l6,'Location','Best');
set(gca,'XTick',12:12:72);
set(gca,'XTicklabel',{12,24,12,24,12,24});
xlim([12 72])
xlabel('每天的时刻/时');ylabel('信号值');
end

