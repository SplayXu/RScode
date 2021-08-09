clc;
clear;
close all;
%产生随机序列
Input = [8,4,0,8,0,1,5,1,0,13,1];
%将11位信息序列编码成15位
RsEnCode = RsEncode(Input);
%将其转换成2进制符号,RsTrans是一个60位的2进制符号串
RsTrans = zeros(1,60);
for ii = 1:1:15
    RsTrans(1,4*ii-3:4*ii) = dec2bin(RsEnCode(1,ii));
end;

%channel and mod
%BPSK调制
RsSend = 1-2*RsTrans;
%不加噪
RsRecv = RsSend;
RsRecv(8) = -1*RsRecv(8);
RsRecv(20) = -9*RsRecv(20);
%信道接收之后要进行判决
for ii = 1:1:60
    if RsRecv(1,ii) <0
        RsRecv(1,ii) = 1;
    else
        RsRecv(1,ii) = 0;
    end
end


%demod
%判决之后先从二进制转换成十进制
NoisedRsCode = zeros(1,15);
for ii = 1:1:15
    NoisedRsCode(1,ii) = bin2dec(RsRecv(1,4*ii-3:4*ii));
end
%计算伴随式
SyndromCalc = RsDecodeCalcSynd(NoisedRsCode);
%伴随式为0说明没有错误就可以直接输出了
error_exist=0;
for ii = 1:1:length(SyndromCalc)
    if(SyndromCalc(1,ii)~=0)
        error_exist = 1;
        break;
    end
end

if (error_exist ==0)
    output = NoisedRsCode(1,5:15);
else
    %否则就需要首先massey迭代法计算错误位置多项式
    [ErrPosPolyCalc, SigmaCalc] = RsDecodeIterate(SyndromCalc);
    %错误多项式求根
    RootCalc = RsDecodeRoot(ErrPosPolyCalc);
    %这里可能出现没有根的情况，可以从最大似然概率的角度分析
    if (RootCalc(1,1)==-1)
        output = NoisedRsCode(1,5:15);
    else
        %forney计算出错误位置和错误数值
        [ErrorValueCalc, ErrorPositionCalc] = RsDecodeForney(SyndromCalc, ErrPosPolyCalc, RootCalc);
        %计算出来之后在错误位置再将它加回去修正错误
        for ii = 1:1:length(ErrorPositionCalc)
            NoisedRsCode(1,ErrorPositionCalc(1,ii)+1) = RsSymbolAdd(NoisedRsCode(1,ErrorPositionCalc(1,ii)+1),ErrorValueCalc(1,ii));
        end
        %获得最终输出结果，是11位信息位
        output = NoisedRsCode(1,5:15);
    end;
end;

sum(Input-output)