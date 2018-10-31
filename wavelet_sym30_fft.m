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
        F1=Fi; %ѡ����� 
        aa='Fi'; 
    end
    if l==2
        F1=Fm; %ѡ����� 
        aa='Fm'; 
    end
    if l==3
        F1=Fj; %ѡ����� 
        aa='Fj';
    end

for m=1:18 %ѡ��ڼ�����������18������
% [A,D]=dwt(Fi(1,:),'db5');
[C,L]=wavedec(F1(m,:),lev,wname);%һά��߶�С���ֽ�                
D = wrcoef('d',C,L,wname,5);%�ؽ�ĳ5�θ�ƵС��ϵ��

figure()
plot(t,D,'m')

ylabel('d5(��5���Ƶ��������)');
xlabel('ÿ���ʱ��/ʱ');
set(gca,'XTick',12:12:72);
set(gca,'XTicklabel',{12,24,12,24,12,24});
xlim([12 72])    
tt=strcat(num2str(m),'��Ҷ��',aa,'�źŵ�5���ƵС��ϵ���ع�');
suptitle(tt);

%��d5�ķ����׺���λ��
N=length(D);%���ݳ���
fs=2;%�趨����Ƶ��
y=fft(D,N);%����fft�任
mag=abs(y);%���ֵ
ang=angle(y);%����λ
f=(0:N-1)*fs/N;%������Ƶ�ʵı��ʽΪf=(0:M-1)*Fs/M
[o,p] = find(mag == max(mag));
[maxv,maxind] = findpeaks(D,'minpeakdistance',3);
minv = min(D);
if length(maxv)== 1
    maxv(1) = maxv;
    maxv(2) = maxv;
end

if l == 1
Tt(1,m) = 1/f(p(1)); %�洢Fi�ź�����
qt(1,m) = ang(p(1)); %�洢��λ
Ft(1,m) = (maxv(1) - minv + maxv(2) - minv)/4; %�洢��ֵ
end
if l == 2
Tt(2,m) = 1/f(p(1)); %�洢Fm�ź�����
qt(2,m) = ang(p(1));
Ft(2,m) = (maxv(1) - minv + maxv(2) - minv)/4;
end
if l == 3
Tt(3,m) = 1/f(p(1)); %�洢Fj�ź�����
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
