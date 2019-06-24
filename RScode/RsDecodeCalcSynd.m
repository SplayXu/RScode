function [ SyndromCalc ] = RsDecodeCalcSynd( NoisedRsCode )
%RSDECODECALCSYND Summary of this function goes here
%   Detailed explanation goes here

%�ӱ�ԭԪ�ķ��ݱ�ʾ���ʮ�����������Ƕ�Ӧ��ϵ��ע�ⱾԭԪ�����Ǵ�0��ʼ�ģ�������Ҫ��1
benyuanyuan2int = [1,2,4,8,3,6,12,11,5,10,7,14,15,13,9];

%ע�����Ĵ���λ������0��ʼ�ģ�����ʽ���ռ�������[12,15,15,12]
%���վ�����[1,0,2,9,0,1,2,3,4,5,6,7,8,9,4];

%�������ʽ��4λ
SyndromCalc = zeros(1,4);
for ii = 1:1:4
    %ÿһλ���ǼӺ͵���ʽ
    for tt = 1:1:15
        mi = mod(ii*(tt-1),15);
        %����ת����ʮ������
        intnum = benyuanyuan2int(1,mi+1);
        %ʮ��������ϵ�����
        mul_res = RsSymbolMul(NoisedRsCode(1,tt),intnum);
        %��֮�����
        SyndromCalc(1,ii) = RsSymbolAdd(SyndromCalc(1,ii),mul_res);
    end;
end;
end

