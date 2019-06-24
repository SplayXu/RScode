function [ ret ] = RsSymbolDiv( div1, div2 )
%RSSYMBOLDIV Summary of this function goes here
%   Detailed explanation goes here

%��һ��ʮ������ת����ԴԪ�ķ��ݱ�ʾ��������ִ���ԴԪ�ķ���
int2benyuanyuan = [0,1,4,2,8,5,10,3,14,9,7,6,13,11,12];
%�ӱ�ԭԪ�ķ��ݱ�ʾ���ʮ�����������Ƕ�Ӧ��ϵ��ע�ⱾԭԪ�����Ǵ�0��ʼ�ģ�������Ҫ��1
benyuanyuan2int = [1,2,4,8,3,6,12,11,5,10,7,14,15,13,9];

%�ж������Ƿ�Ϸ�
if (div1 >15 || div1 <=0)
    disp('invalid input div1!\n');
    return ;
end;
if (div2 >15 || div2 <=0)
    disp('invalid input div2!\n');
    return;
end;

%�����൱�ڰѳ���ȡ����Ȼ��ͱ��������
fangmi_divider = int2benyuanyuan(1,div2);
if fangmi_divider ~=0 %0��ʱ����Ҫȡ����
    fangmi_divider = 15 - fangmi_divider;
end;
dividernow = benyuanyuan2int(1, fangmi_divider+1);
fangmi = mod(int2benyuanyuan(1,div1) + int2benyuanyuan(1,dividernow),15);
ret = benyuanyuan2int(1, fangmi+1);

end

