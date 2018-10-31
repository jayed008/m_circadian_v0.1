
% strFileName=strcat('D:\Data\data_Fi.txt');
% Data=load(strFileName);
clc;clear;
close all;
t=xlsread('Data/data_t.xlsx');
Fi=xlsread('Data/data_Fi.xlsx');
Fj=xlsread('Data/data_Fj.xlsx');
Fm=xlsread('Data/data_Fm.xlsx');
lev = 6;
Tt = zeros(3,18);
qt = zeros(3,18);
Ft = zeros(3,18);
e24db = zeros(1,30);
e24cf = zeros(1,5);
e24sy = zeros(1,30);
e24fk = zeros(1,5);
e24bi = zeros(1,15);

for wn =1:85
    if wn <= 30
        wname = strcat('db',num2str(wn));
    end
    
    if wn > 30 && wn <= 35
        wname = strcat('coif',num2str(wn-30));
    end
    
    if wn > 35 && wn <= 65
        wname = strcat('sym',num2str(wn-35));
    end
    
    if wn > 65 && wn <= 70
        fkn = [4,6,8,14,22];
        wname = strcat('fk',num2str(fkn(wn-65)));
    end
    
    if wn > 70 && wn <= 85
        rbion = [1.1,1.3,1.5,2.2,2.4,2.6,2.8,3.1,3.3,3.5,3.7,3.9,4.4,5.5,6.8];
        wname = strcat('bior',num2str(rbion(wn-70)));
    end

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



end
end
csvwrite(strcat('table/',wname,'_zhouqi.csv'),Tt);
csvwrite(strcat('table/',wname,'_xiangwei.csv'),qt);
csvwrite(strcat('table/',wname,'_fuzhi.csv'),Ft);

    if wn <= 30
        e24db(wn) = sum(Tt(:)==24);
    end
    
    if wn > 30 && wn <= 35
        e24cf(wn-30) = sum(Tt(:)==24);
    end
    
    if wn > 35 && wn <= 65
        e24sy(wn-35) = sum(Tt(:)==24);
    end
    
    if wn > 65 && wn <= 70
        e24fk(wn-65) = sum(Tt(:)==24);
    end
    
    if wn > 70 && wn <= 85
        e24bi(wn-70) = sum(Tt(:)==24);
    end

end
figure()
plot(e24db);
set(gca,'XTick',1:1:30);
set(gca,'XTicklabel',{'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10','db11','db12','db13','db14','db15','db16','db17','db18','db19','db20','db21','db22','db23','db24','db25','db26','db27','db28','db29','db30'});
xlim([0 30])
xlabel('Wavelets');ylabel('The number of period with 24 hours');

figure()
plot(e24cf);
set(gca,'XTick',1:1:5);
set(gca,'XTicklabel',{'coif1','coif2','coif3','coif4','coif5'});
xlim([0 5])
xlabel('Wavelets');ylabel('The number of period with 24 hours');

figure()
plot(e24sy);
set(gca,'XTick',1:1:30);
set(gca,'XTicklabel',{'sym2','sym3','sym4','sym5','sym6','sym7','sym8','sym9','sym10','sym11','sym12','sym13','sym14','sym15','sym16','sym17','sym18','sym19','sym20','sym21','sym22','sym23','sym24','sym25','sym26','sym27','sym28','sym29','sym30','sym31'});
xlim([0 30])
xlabel('Wavelets');ylabel('The number of period with 24 hours');

figure()
plot(e24fk);
set(gca,'XTick',1:1:5);
set(gca,'XTicklabel',{'fk4','fk6','fk8','fk14','fk22'});
xlim([0 5])
xlabel('Wavelets');ylabel('The number of period with 24 hours');

figure()
plot(e24bi);
set(gca,'XTick',1:1:15);
set(gca,'XTicklabel',{'bior1.1','bior1.3','bior1.5','bior2.2','bior2.4','bior2.6','bior2.8','bior3.1','bior3.3','bior3.5','bior3.7','bior3.9','bior4.4','bior5.5','bior6.8'});
xlim([0 15])
xlabel('Wavelets');ylabel('The number of period with 24 hours');


