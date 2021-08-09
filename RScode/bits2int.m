%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function : bin to dec based on bin length
%input    : bits,  bin array
%output   : dec,  the output dec num
%version  : V1.0
%writer   : SplayXu
%date     : 2013.8.9
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dec_num]=bits2int(bits);

len_bits      = length(bits);
index_2       = len_bits-1:-1:0;
index_2       = 2.^index_2;
dec_num       = sum(bits.*index_2);
