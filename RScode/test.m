clc;
clear;
close all;
%�����������
Input = [8,4,0,8,0,1,5,1,0,13,1];
%��11λ��Ϣ���б����15λ
RsEnCode = RsEncode(Input);
%����ת����2���Ʒ���,RsTrans��һ��60λ��2���Ʒ��Ŵ�
RsTrans = zeros(1,60);
for ii = 1:1:15
    RsTrans(1,4*ii-3:4*ii) = dec2bin(RsEnCode(1,ii));
end;

%channel and mod
%BPSK����
RsSend = 1-2*RsTrans;
%������
RsRecv = RsSend;
RsRecv(8) = -1*RsRecv(8);
RsRecv(20) = -9*RsRecv(20);
%�ŵ�����֮��Ҫ�����о�
for ii = 1:1:60
    if RsRecv(1,ii) <0
        RsRecv(1,ii) = 1;
    else
        RsRecv(1,ii) = 0;
    end
end


%demod
%�о�֮���ȴӶ�����ת����ʮ����
NoisedRsCode = zeros(1,15);
for ii = 1:1:15
    NoisedRsCode(1,ii) = bin2dec(RsRecv(1,4*ii-3:4*ii));
end
%�������ʽ
SyndromCalc = RsDecodeCalcSynd(NoisedRsCode);
%����ʽΪ0˵��û�д���Ϳ���ֱ�������
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
    %�������Ҫ����massey�������������λ�ö���ʽ
    [ErrPosPolyCalc, SigmaCalc] = RsDecodeIterate(SyndromCalc);
    %�������ʽ���
    RootCalc = RsDecodeRoot(ErrPosPolyCalc);
    %������ܳ���û�и�����������Դ������Ȼ���ʵĽǶȷ���
    if (RootCalc(1,1)==-1)
        output = NoisedRsCode(1,5:15);
    else
        %forney���������λ�úʹ�����ֵ
        [ErrorValueCalc, ErrorPositionCalc] = RsDecodeForney(SyndromCalc, ErrPosPolyCalc, RootCalc);
        %�������֮���ڴ���λ���ٽ����ӻ�ȥ��������
        for ii = 1:1:length(ErrorPositionCalc)
            NoisedRsCode(1,ErrorPositionCalc(1,ii)+1) = RsSymbolAdd(NoisedRsCode(1,ErrorPositionCalc(1,ii)+1),ErrorValueCalc(1,ii));
        end
        %�����������������11λ��Ϣλ
        output = NoisedRsCode(1,5:15);
    end;
end;

sum(Input-output)