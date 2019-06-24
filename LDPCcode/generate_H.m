%this module is to generate H matrix(1008 x 2016)
%save the real H matrix as "H_ldpc"

z = 56; %��Ĵ�С��56x56
load Matrix(2016,1008)Block56.mat
%�����������LDPC���У�����ά����1008x2016
H_ldpc = zeros(1008,2016);
for ii = 1:1:18
    for jj = 1:1:36
        %����ÿһ��Ԫ�أ����Զ�Ӧ��Ԫ�ؿ���д���
        if (H_block(ii,jj)~=0) %����0�Ͳ��ô�����
            bias = H_block(ii,jj);%����ƫ��
            start_l = 56*(ii-1);%����ʼ����
            start_c = 56*(jj-1);%����ʼ����
            for tt = 1:1:56
                if bias >56
                    bias = 1;
                end
                H_ldpc(start_l + tt , start_c + bias)=1;
                bias = bias +1;
            end
        end
    end
end
H_ldpc(1,1008)=0;%�����������

%֮���ǲ���Hsת��
Hs = H_ldpc(:,1009:2016);
%�������Hs��ת��
Hst = Hs';
save('H_ldpc','H_ldpc');
save('Hst','Hst');

%������������H_index ��H_index_len
load H_ldpc.mat
H_index = zeros(1008,8);%����洢����H����ÿһ�е�Ϊ1������
H_index_len = zeros(1008,1); %����洢����H����ÿһ��Ϊ1�������ĸ���
maxx = -1;
for ii = 1:1:1008
    cnt = 0;
    for jj = 1:1:2016        
        if(H_ldpc(ii,jj)==1)
            cnt = cnt +1;
            H_index(ii,cnt) = jj;
        end
    end
    H_index_len(ii,1) = cnt;
end
save('H_index','H_index');
save('H_index_len','H_index_len');
