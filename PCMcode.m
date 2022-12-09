function[A,t]=PCMcode(bin_in,V,tp)
nt=size(bin_in,2);
s=16;                        %������Ϊ16
ct=nt*2;                      %500Mb/s T=2ns
    t=linspace(0,ct,(s*nt));
     switch tp                   %tp=1��ʾNRZ��2��ʾRZ��3��ʾManchester 
    case 1
        for i1=1:nt
            A(s*(i1-1)+1:s*i1)=V*bin_in(i1);  %��PR��������NRZ��
        end
    case 2
        for i1=1:nt
            A(s*(i1-1)+1:s*(i1-1)+8)=V*bin_in(i1);  %��PR��������RZ��
            A(s*(i1-1)+9:s*i1)=0;
        end
    case 3
      for i1=1:nt
      A(s*(i1-1)+1:s*(i1-1)+8)=V*bin_in(i1); %��PR��������Manchester ��
      A(s*(i1-1)+9:s*i1)=-V*(bin_in(i1)-1);
      end
    otherwise
        error('error!tp');
end