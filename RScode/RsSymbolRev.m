function [ ret ] = RsSymbolRev( rev1 )
%RSSYMBOLREV Summary of this function goes here
%   Detailed explanation goes here
%��һ��ʮ������ת����ԴԪ�ķ��ݱ�ʾ��������ִ���ԴԪ�ķ���
int2benyuanyuan = [0,1,4,2,8,5,10,3,14,9,7,6,13,11,12];
%�ӱ�ԭԪ�ķ��ݱ�ʾ���ʮ�����������Ƕ�Ӧ��ϵ��ע�ⱾԭԪ�����Ǵ�0��ʼ�ģ�������Ҫ��1
benyuanyuan2int = [1,2,4,8,3,6,12,11,5,10,7,14,15,13,9];

%�ж������Ƿ�Ϸ�
if (rev1 >15 || rev1 <=0)
    disp('invalid input rev1!\n');
    return ;
end;

%�����൱�ڰѳ���ȡ����Ȼ��ͱ��������
fangmi_rev = int2benyuanyuan(1,rev1);
if fangmi_rev ~=0 %0��ʱ����Ҫȡ����
    fangmi_rev = 15 - fangmi_rev;
end;
revnow = benyuanyuan2int(1, fangmi_rev+1);

ret = revnow;

end

