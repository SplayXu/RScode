error_framerate = zeros(1,5);
error_symbolrate = zeros(1,5);
itertimes = 1000000;
for EbN0 = 0:2:8
    
    %����֡����
    error_framenum = 0;
    %�����������
    error_symbolnum = 0;
    
    for framenum = 1:1:itertimes

        %�����������
        Input = ceil(rand(1,11)*16)-1;
        %��11λ��Ϣ���б����15λ
        RsEnCode = RsEncode(Input);
        %����ת����2���Ʒ���,RsTrans��һ��60λ��2���Ʒ��Ŵ�
        RsTrans = zeros(1,60);
        for ii = 1:1:15
            RsTrans(1,4*ii-3:4*ii) = dec2bin(RsEnCode(1,ii));
        end;

        %BPSK����
        RsSend = 1-2*RsTrans;
        %����RsChannel�ŵ�������,SNR = EbN0+10lg(22/15);
        RsRecv = awgn(RsSend,EbN0+1.663);
        %�ŵ�����֮��Ҫ�����о�
        for ii = 1:1:60
            if RsRecv(1,ii) <0
                RsRecv(1,ii) = 1;
            else
                RsRecv(1,ii) = 0;
            end
        end
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
        %ͳ�ƴ���֡�����ʹ����������
        frame_error = 0;
        for ii = 1:1:11
            if(Input(1,ii)~=output(1,ii))
                error_symbolnum = error_symbolnum +1;%����������һ
                frame_error = 1;%֡�д���
            end
        end;
        if (frame_error == 1)
            error_framenum = error_framenum +1;
        end;
    end;
    
    error_framerate(1,EbN0/2+1) = error_framenum/itertimes;
    error_symbolrate(1,EbN0/2+1) = error_symbolnum/(itertimes*11);
    
end
x = 0:2:8;
semilogy(x,error_framerate,'-*r', x,error_symbolrate,'-ob' );
title ('RsCode Performace');
xlabel('Eb/N0'); 
ylabel('�������/��֡��');
legend('Error Frame Ratio','Error Symbol Ratio');
grid on;
%semilogy(x,error_symbolrate,'b');






