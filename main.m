clear all;
V=10;                 %�������
eb_ratio=20;          %�����
sample=1000;          %��Ϣ��������

prn=PRseries(sample); %����α�������
src=PCMcode(prn,V,3); %��Դ����(NRZ)
alfa=0.247;           %���˵���ĳ�������λΪdB/km
l=100;                %���˳��ȣ���λΪkm

Aled=0.9;             %��Դ����
trans=Aled*src;       %��Դ��ע������ź�ת��Ϊ�⹦���ź�
trans=10^(-alfa*1/10)*trans; %�⹦���ź��ڹ����д��䣬�źű�˥��
recv=photo_detect(trans);     %p-i-n����������
yout=awgn(recv,eb_ratio,'measured'); %���ӵ�Ч��˹������
[B,A]=butter(16,1/4);               %�û������ƥ���˲�����������8��butterworth�˲���������ֹ���ֽ�Ƶ��4/16=1/4
Azeros=zeros(1,16);
vout=filter(B,A,[yout Azeros]); %�����˲�����ʱ�ӣ��������ݺ��油16����

Vth=(max(vout)-min(vout))*0.5; %�о��߽�
for i=1:sample
    if(vout(i*16+8:16:(i+1)*16)>Vth) %���NRZ�룬������=T/16�������˲�����ʱ�ӣ�ǰ��32������ȥ��
        cout(i)=0;
    else
        cout(i)=1;
    end
end  

figure(1);

M_plot=[1:1:1000];
subplot(3,1,1)
plot(M_plot,trans(1:16:16000))%�����ź�
title('�����ź�')
axis([0,200,-2,10]);
hold on;
subplot(3,1,2)
plot(M_plot,yout(1:16:16000))%����ԭʼ�ź�
title('����ԭʼ�ź�')
axis([0,200,-2,10]);
hold on;
subplot(3,1,3)
plot(M_plot,cout(1:1:1000))%�о����ź�
title('�о����ź�')
axis([0,200,-0.25,1.25]);
hold on;

ber=sum(abs(cout(1:sample)-prn(1:sample)))/sample %�����ʼ���

xt=repmat([1:32],1,sample/2);                     %��ͼ����
figure(2);
plot(xt,vout(17:16*sample+16),'LineWidth',0.75);