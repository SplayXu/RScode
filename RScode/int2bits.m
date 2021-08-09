%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function : dec to bin at setted length
%input    : int_val  the number in dec
%           bits_num the bin length
%output   : bits     the bin sequence after trans
%version  : V1.0
%writer   : lv zhe
%date     : 2013.06.04
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [bits]=int2bits(int_val,bits_num);

bits=zeros(1,bits_num);
int_val=bitand(int_val,(2^bits_num)-1);
for i=1:bits_num-1
    bits(i)=floor(int_val/(2^(bits_num-i)));
    int_val=int_val-bits(i)*(2^(bits_num-i));
end
bits(bits_num)=int_val;