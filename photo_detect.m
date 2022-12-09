function[amp,x]=photo_detect(pt)
nt=size(pt,2);
lambda_c=1.51*10^-6; %����
dt=1.25e-7;         %���ת������Ӧʱ��
h=6.626*10^-34;    %���ʿ˳���
c=3*10^8;         %����
e=1.602*10^-19;   %���ӵ���
vs=c/lambda_c;    %����Ƶ��
yita=0.8;         %����������
Id=5e-9;         %������5nA
x=1:nt;
for i=1:nt
    N(i)=(yita/(h*vs)*pt(i)+Id/e)*dt; %���չ�������ptΪ�ź�����
    pn=poissrnd(N(i));                %����������Poisson�ֲ�
    amp(i)=e*pn/dt;                  %�������
end