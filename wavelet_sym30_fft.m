% strFileName=strcat('D:\Data\data_Fi.txt');
% Data=load(strFileName);
clc;clear;
close all;
t=xlsread('Data/data_t.xlsx');
Fi=xlsread('Data/data_Fi.xlsx');
Fj=xlsread('Data/data_Fj.xlsx');
Fm=xlsread('Data/data_Fm.xlsx');
lev = 6;
wname = 'sym30';

for l=1:3
    if l==1
        F1=Fi; %选择参数 
        aa='Fi'; 
    end
    if l==2
        F1=Fm; %选择参数 
        aa='Fm'; 
    end
    if l==3
        F1=Fj; %选择参数 
        aa='Fj';
    end

for m=1:18 %选择第几个样本，共18个样本
% [A,D]=dwt(Fi(1,:),'db5');
[C,L]=wavedec(F1(m,:),lev,wname);%一维多尺度小波分解                
D = wrcoef('d',C,L,wname,5);%重建某5次高频小波系数

figure()
plot(t,D,'m')

ylabel('d5(第5层高频函数分量)');
xlabel('每天的时刻/时');
set(gca,'XTick',12:12:72);
set(gca,'XTicklabel',{12,24,12,24,12,24});
xlim([12 72])    
tt=strcat(num2str(m),'号叶子',aa,'信号第5层高频小波系数重构');
suptitle(tt);

%求d5的幅度谱和相位谱
N=length(D);%数据长度
fs=2;%设定采样频率
y=fft(D,N);%进行fft变换
mag=abs(y);%求幅值
ang=angle(y);%求相位
f=(0:N-1)*fs/N;%横坐标频率的表达式为f=(0:M-1)*Fs/M
[o,p] = find(mag == max(mag));
[maxv,maxind] = findpeaks(D,'minpeakdistance',3);
minv = min(D);
if length(maxv)== 1
    maxv(1) = maxv;
    maxv(2) = maxv;
end

if l == 1
Tt(1,m) = 1/f(p(1)); %存储Fi信号周期
qt(1,m) = ang(p(1)); %存储相位
Ft(1,m) = (maxv(1) - minv + maxv(2) - minv)/4; %存储幅值
end
if l == 2
Tt(2,m) = 1/f(p(1)); %存储Fm信号周期
qt(2,m) = ang(p(1));
Ft(2,m) = (maxv(1) - minv + maxv(2) - minv)/4;
end
if l == 3
Tt(3,m) = 1/f(p(1)); %存储Fj信号周期
qt(3,m) = ang(p(1));
Ft(3,m) = (maxv(1) - minv + maxv(2) - minv)/4;
end

figure()
semilogx(f,mag);

figure()
semilogx(f,ang);

end
end
csvwrite('sym30_zhouqi.csv',Tt);
csvwrite('sym30_xinagwei.csv',qt);
csvwrite('sym30_fuzhi.csv',Ft);
