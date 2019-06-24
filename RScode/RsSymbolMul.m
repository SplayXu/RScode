function [ ret ] = RsSymbolMul( mul1, mul2 )
%RSSYMBOLMUL Summary of this function goes here
%   Detailed explanation goes here

%��һ��ʮ������ת����ԴԪ�ķ��ݱ�ʾ��������ִ���ԴԪ�ķ���
int2benyuanyuan = [0,1,4,2,8,5,10,3,14,9,7,6,13,11,12];
%�ӱ�ԭԪ�ķ��ݱ�ʾ���ʮ�����������Ƕ�Ӧ��ϵ��ע�ⱾԭԪ�����Ǵ�0��ʼ�ģ�������Ҫ��1
benyuanyuan2int = [1,2,4,8,3,6,12,11,5,10,7,14,15,13,9];

%�ж������Ƿ�Ϸ������0�д���ȶ
if (mul1 >15 || mul1 <0)
    disp('invalid input mul1!\n');
    return ;
end;
if (mul2 >15 || mul2 <0)
    disp('invalid input mul2!\n');
    return;
end;

 % ������0�������������Ϊ��֮��ı����·�ļ��ӵ�
if (mul1 ==0 || mul2 == 0)
    ret =  0;
else % �������
    fangmi = mod(int2benyuanyuan(1,mul1) + int2benyuanyuan(1,mul2),15);
    ret = benyuanyuan2int(1, fangmi+1);
end;

end


