function [ retpoly ] = RsPolyMul( poly1, poly2 )
%RSPOLYMUL Summary of this function goes here
%   Detailed explanation goes here

len1 = length(poly1);
len2 = length(poly2);
retpoly = zeros(1, max(len1,len2));

%����ʽ����Ǿ��
%������Ĭ����1x11 ��1x11���
for ii = 1:1:11%����������Ĭ��������1x6�������1x11��
    rec = 0;
    for tt = 1:1:min(ii,6)%�ӵ�һά�ĽǶ������ڶ�ά��ֹԽ��
        if ii-tt>5 
            continue;
        end;
        rec = RsSymbolAdd(rec , RsSymbolMul(poly1(1,tt),poly2(1,ii-tt+1))); 
    end;
    retpoly(1,ii) = rec;
end;

end

