function [ RootCalc ] = RsDecodeRoot( ErrPosPolyCalc )

%������ֻ�����˴���������1������������û�д�����ô�죿
%����������һ������������޽⣬����RootCalc=[-1]��ʾ
%RSDECODEROOT Summary of this function goes here
%   Detailed explanation goes here
%��һ����һ������������������û�д�����Ҫ��һ�´���λ������������1λ�û��м�������λ�þ��м������λ�����ⷨ���Ը���

RootCalc=[-1,0];
if (ErrPosPolyCalc(1,3)~=0)%������λ�ò���0����˵������������
    %�Ը���
    cnt = 1;
    for ii = 1:1:15
        if(add(1,RsSymbolMul(ErrPosPolyCalc(1,2),ii),mul(ErrPosPolyCalc(1,3),ii,ii))==0)
            RootCalc(1,cnt) = ii;
            cnt = cnt+1;
            if (cnt==3)%�ҵ���������
                break;
            end;
        end
    end;
elseif (ErrPosPolyCalc(1,2)~=0)%�ڶ���λ�ò���0��˵����1������
    %�Ը���
    cnt = 1;
    for ii = 1:1:15
        if(RsSymbolAdd(1,RsSymbolMul(ErrPosPolyCalc(1,2),ii))==0)
            RootCalc(1,cnt) = ii;
            cnt = cnt+1;
            if (cnt==2)%�ҵ���������
                break;
            end;
        end
    end;
end;

if (RootCalc(1,2) == 0)%��˵��ֻ��һ����
    RootCalc = RootCalc(:,1:1);%ֻȡ��һ��Ԫ��
end
end

function [ret] = mul(input1, input2, input3)
    temp = RsSymbolMul(input1, input2);
    ret = RsSymbolMul(temp,input3);
end
function [ret] = add(input1, input2, input3)
    temp = RsSymbolAdd(input1, input2);
    ret = RsSymbolAdd(temp,input3);
end