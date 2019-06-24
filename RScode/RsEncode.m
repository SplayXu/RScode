function [ RsEnCode ] = RsEncode( input )
%RSENCODE Summary of this function goes here
%   Detailed explanation goes here

RsEnCode = zeros(1,15);
for ii = 5:1:15%��11λֱ�����
    RsEnCode(1,ii) = input(1,ii-4);
end;
%�Ĵ���ȡ��������ԭ����ʽp(x) = x^4 + x + 1

%����һ��4λ�Ĵ���
reg = zeros(1,4);
%���ɶ���ʽ��ϵ��
g = [7,8,12,13,1];
for ii = 11:-1:1
    %����ķ���
    rev = RsSymbolAdd(reg(1,4),input(1,ii));%g4ϵ����1�Ͳ��ó���
    %ѭ����λ���
    for tt = 4:-1:2
        reg(1,tt) = RsSymbolAdd(RsSymbolMul(g(1,tt),rev), reg(1,tt-1));
    end;
    reg(1,1) = RsSymbolMul(g(1,1),rev);
end;

%���Ĵ������ֵ����
for ii = 1:1:4
    RsEnCode(1,ii) = reg(1,ii);
end;
end

