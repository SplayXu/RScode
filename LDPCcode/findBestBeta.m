%�˺�������Ѱ����ѵĦ�ֵ
load H_index.mat;
load H_index_len.mat;
load Hst.mat;
load H_ldpc.mat;
load H_var.mat;
load H_var_len.mat

error_framerate = zeros(1,11);
error_bitrate = zeros(5,11);
error_limit = [50,30,15,5];

%snr = [-2.4, -2.2, -2.0, -1.8, -1.6]; %���������Ϊ-2
iter = 0;
for snr = -2.4 : 0.2 : -1.6
    iter = iter + 1;
for b = 0:0.1:1
    
    %����֡����
    totalerror_framenum = 0;
    %�����������
    totalerror_bitnum = 0;
    lp = 0; %��¼�ܵ�ѭ������
    while 1
        lp = lp+1;
        %�����������1x1008
        Input = ceil(rand(1,1008)*2)-1;
        %��1x1008λ��Ϣ���б����1x2016λ
        LDPCEnCode = Encode(Input,Hst);

        %BPSK����
        LDPCSend = 1-2*LDPCEnCode;
        %����RsChannel�ŵ�������,SNR = EbN0+10lg(2);
        LDPCRecv = awgn(LDPCSend,snr+3);
       
        
        %����֮��ĵ�һ������ʼ��,��ó�ʼ������Ϣ
        y_snr = 10^(snr/10);
        LDPCRecv = 4 * LDPCRecv * y_snr;
        
        u = zeros(1008,2016);
        v = zeros(2016,1008);
        [isSuc, errorframenum, errorbitnum] = Decode_MinSumBeta( LDPCRecv, H_index, H_index_len, H_var, H_var_len, u, v, H_ldpc, LDPCEnCode, b );
        
        totalerror_framenum = totalerror_framenum + errorframenum;
        totalerror_bitnum = totalerror_bitnum + errorbitnum;
        
        if(isSuc ==0) %�����г����˴���
            fprintf('�� %d ֡�����˴���\n',lp);
            fprintf('snr = %d ����֡�� ��%d\n', snr,totalerror_framenum);
            fprintf('snr = %d ��������� ��%d\n', snr,totalerror_bitnum);
        else
            fprintf('�� %d ֡û���ִ���\n',lp);
            fprintf('snr = %d ����֡�� ��%d\n', snr,totalerror_framenum);
            fprintf('snr = %d ��������� ��%d\n', snr,totalerror_bitnum);
        end
        
        %ѭ���˳����о�����
        if(totalerror_framenum > 100) 
            break;
        end
        
    end
    
    %error_framerate(1,snr+5) = totalerror_framenum/lp;
    error_bitrate(iter,round(10 * b + 1)) = totalerror_bitnum/(lp*1008);%ֻ��Ҫ����������
    
end
end
%��ͼ
figure(1);
x = 0:0.1:1;
plot( x,error_bitrate(1,:),'-r', x,error_bitrate(2,:),'-g',x,error_bitrate(3,:),'-b',x,error_bitrate(4,:),'-y',x,error_bitrate(5,:),'-k');

title ('LDPC different �� code Performace');
xlabel('�µ�ֵ'); 
ylabel('BER');
legend('snr = -2.4dB','snr = -2.2dB', 'snr = -2.0dB', 'snr = -1.8dB', 'snr = -1.6dB');
grid on;
%semilogy(x,error_symbolrate,'b');



