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
        F1=Fi; %ѡ����� 
    end
    if l==2
        F1=Fm; %ѡ����� 
    end
    if l==3
        F1=Fj; %ѡ����� 
    end

for m=1:6  %ѡ��ڼ�����������18������
[C,L]=wavedec(F1(m,:),lev,wname);%һά��߶�С���ֽ�
figure;
j=1;                    
for i=1:6
f=strcat('a',num2str(i));
g=strcat('d',num2str(i));           
A(i,:)=wrcoef('a',C,L,wname,i);                 % �ع���Ƶϵ��
D(i,:)=wrcoef('d',C,L,wname,i);%�ؽ�ĳһ��С��ϵ��   �ع���Ƶϵ��

subplot(6,2,j)
plot(t,A(i,:),'b');
ylabel(f);
xlabel('ÿ���ʱ��/ʱ');
j=j+1;
set(gca,'XTick',12:12:72);
set(gca,'XTicklabel',{12,24,12,24,12,24});
xlim([12 72])

subplot(6,2,j)
plot(t,D(i,:),'m');
ylabel(g);
xlabel('ÿ���ʱ��/ʱ');
j=j+1;
set(gca,'XTick',12:12:72);
set(gca,'XTicklabel',{12,24,12,24,12,24});
xlim([12 72])


end 

    if l==1
        aa='Fi'; %ѡ����� 
    end
    if l==2
        aa='Fm'; %ѡ����� 
    end
    if l==3
        aa='Fj'; %ѡ����� 
    end
    
tt=strcat(num2str(m),'��Ҷ��',aa,'�ź�С���ֽ�ͼ');
suptitle(tt);


%��ȡ��ֵ 
sigma = wnoisest(C,L,1);   %ʹ�ÿ⺯��wnoisest��ȡ��һ���ϸ��ϵ�������������ı�׼ƫ��  
N = numel(F1(m,:));         %�����źŵĳ���  
thr = sigma*sqrt(2*log(N));%������ֵ  
  
%ȫ����ֵ����  
keepapp = 1;%����ϵ����������  
F2(m,:) = wdencmp('gbl',C,L,wname,lev,thr,'s',keepapp);  
denoisexh = wdencmp('gbl',C,L,wname,lev,thr,'h',keepapp);  
 
% figure;
% plot(t,F1(m,:),'k:')  
% hold on
% plot(t,F2,'r-')
% legend('Fj-ԭʼ�ź�','Fj-С��ȥ���');
% title('Fj�ź�ȥ��Ч��'); 
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
        bb='Fi'; %ѡ����� 
    end
    if l==2
        bb='Fm'; %ѡ����� 
    end
    if l==3
        bb='Fj'; %ѡ����� 
    end
ttt = strcat('1,4,5��ҶƬ',bb,'ԭʼ�ź���С��ȥ���ź�');   
title(ttt);

l1 = strcat('1��',bb,'ԭʼ�ź�');
l2 = strcat('1��',bb,'С��ȥ����ź�');
l3 = strcat('4��',bb,'ԭʼ�ź�');
l4 = strcat('4��',bb,'С��ȥ����ź�');
l5 = strcat('5��',bb,'ԭʼ�ź�');
l6 = strcat('5��',bb,'С��ȥ����ź�');
legend(l1,l2,l3,l4,l5,l6,'Location','Best');
set(gca,'XTick',12:12:72);
set(gca,'XTicklabel',{12,24,12,24,12,24});
xlim([12 72])
xlabel('ÿ���ʱ��/ʱ');ylabel('�ź�ֵ');
end

