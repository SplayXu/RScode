function [ ret ] = RsSymbolAdd( add1, add2 )%2 operating num at both sides of +
%RSSYMBOLADD Summary of this function goes here
%   Detailed explanation goes here

%if the input num is valid
if (add1<0 || add1 >15)
    disp('invalid add1!');
    return;
end
if (add2<0 || add2 >15)
    disp('invalid add2!');
    return;
end

%change the dec input to binary

[bin1]=int2bits(add1,4);
[bin2]=int2bits(add2,4);
res = bitxor(bin1,bin2);
% temp = 0;
% for ii = 4:-1:1
%     if res(1,ii) ==1
%         temp = temp + 2^(4-ii);
%     end;
% end
[temp]=bits2int(res);
ret = temp;
end

