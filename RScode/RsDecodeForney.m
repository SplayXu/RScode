function [ ErrorValueCalc, ErrorPositionCalc ] = RsDecodeForney( SyndromCalc, ErrPosPolyCalc, RootCalc )

%RSDECODEFORNEY Summary of this function goes here
%   Detailed explanation goes here

%��һ��ʮ������ת����ԴԪ�ķ��ݱ�ʾ��������ִ���ԴԪ�ķ���
int2benyuanyuan = [0,1,4,2,8,5,10,3,14,9,7,6,13,11,12];

%�Ӹ�����ʽRootCalc�õ�����λ��
for ii = 1:1:length(RootCalc)
    ErrorPositionCalc(1,ii) = int2benyuanyuan(1,RsSymbolRev(RootCalc(1,ii)));
end;
%sort(ErrorPositionCalc);%��Ҫ��С��������,�Ҳ����Ӧ�÷��������

%�������ʽ�ʹ���λ�ö���ʽ���
MulPoly = polyMul(SyndromCalc,ErrPosPolyCalc);
%mod (x^2t),��Ϊֻ��x^2t����ֻҪ��>=2t���ȥ���Ϳ�����
w = MulPoly(:,1:4);

%ע��μ������Xp��ʾ���Ǹ�[2,12]�ĵ�����λ��[9,10]
%rootCalc����Ԫ������С�������еģ�������Ϊ�Ը�����˳�������С����
%RsSymbolRev(RootCalc(1,ii))���Ǵ���λ�õ�������ʾ
for ii = 1:1:length(RootCalc)
    %�������w(xp-1)
    ErrorValueCalc(1,ii) = 0;
    for tt = 1:1:4
        cal = 1;
        for s = 1:1:tt-1%�����ݴ�
            cal = RsSymbolMul(cal,RootCalc(1,ii));
        end
        ErrorValueCalc(1,ii) = RsSymbolAdd(ErrorValueCalc(1,ii),RsSymbolMul(w(1,tt),cal));
    end;
    %�����ĸ
    %��Ϊ��(x)����ֻ��1+ax+bx^2����֮��ֻʣ��a,Ҳ����ErrPosPolyCalc(1,2)��Ȼ���󷴾�����
    if (ErrPosPolyCalc(1,2)==0)
        ErrorValueCalc(1,ii) = 0; %���Ӵ���Ϊ0�Ĵ���
    else
        ErrorValueCalc(1,ii) = RsSymbolMul(ErrorValueCalc(1,ii),RsSymbolRev(ErrPosPolyCalc(1,2)));
    end;
end
%��С��������
    if (length(ErrorPositionCalc)==2 && ErrorPositionCalc(1,1)>ErrorPositionCalc(1,2))
         temp = ErrorPositionCalc(1,1); ErrorPositionCalc(1,1) = ErrorPositionCalc(1,2); ErrorPositionCalc(1,2) = temp;
         temp = ErrorValueCalc(1,1);ErrorValueCalc(1,1) = ErrorValueCalc(1,2);ErrorValueCalc(1,2) = temp;
    end
end
function retpoly = polyMul(poly1, poly2)

len1 = length(poly1);
len2 = length(poly2);
retpoly = zeros(1, len1+len2-1);

%����ʽ����Ǿ��

for ii = 1:1:len1+len2-1
    rec = 0;
    for tt = 1:1:len1%�ӵ�һά�ĽǶ������ڶ�ά��ֹԽ��
        if ii-tt+1>len2 
            continue;
        end;
        if ii-tt+1<=0
            continue;
        end;
        rec = RsSymbolAdd(rec , RsSymbolMul(poly1(1,tt),poly2(1,ii-tt+1))); 
    end;
    retpoly(1,ii) = rec;
end;

end
