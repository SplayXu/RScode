function [ ErrPosPolyCalc, SigmaRet ] = RsDecodeIterate( SyndromCalc )
%����Ǵ���λ�ö���ʽ�� sigma����ʽ
%RSDECODEITERATE Summary of this function goes here
%   Detailed explanation goes here


%������������ʼ�ÿμ��ķ���������û�а취���������Ի��������и��ķ���
%ErrPosPoly = [1,11,1,0,0];%����λ�ö���ʽӦ�õĽ��
% %�����ȼ�������ʽ��ֵ
% ErrPosPolyCalc = [1,0,0,0,0];%��ʼ��
% if (RsSymbolAdd(RsSymbolMul(SyndromCalc(1,2),SyndromCalc(1,2)),RsSymbolMul(SyndromCalc(1,1),SyndromCalc(1,3))) == 0)%�����0��Ҳ����û�д�2λ����1λ����
%     for res = 0:1:15%�Ը���
%         if(RsSymbolMul(SyndromCalc(1,1),res)==SyndromCalc(1,2))
%             ErrPosPolyCalc(1,2) = res;
%             break;
%         end;
%     end;
% else %����λ����
%     %ֻ�ܲ����Ը���
%     two_res_exist = 0; %�ж��ǲ���������
%     for res1 = 0:1:15
%         for res2 = 0:1:15
%             if(RsSymbolAdd(RsSymbolMul(SyndromCalc(1,2),res1),RsSymbolMul(SyndromCalc(1,1),res2))==SyndromCalc(1,3) &&RsSymbolAdd(RsSymbolMul(SyndromCalc(1,3),res1),RsSymbolMul(SyndromCalc(1,2),res2))==SyndromCalc(1,4))
%                 two_res_exist = 1; %˵����������
%                 ErrPosPolyCalc(1,2) = res1;
%                 ErrPosPolyCalc(1,3) = res2;
%             end;
%             if two_res_exist ==1
%                 break;
%             end;
%         end;
%         if two_res_exist ==1
%                 break;
%         end;
%     end;
% end;

%�����и��ķ���,֮������6x5������5x5����Ϊ���Ц�(-1)(x)��Ҫ����
SigmaCalc =zeros(6,5);
% sigma Ӧ�õĽ����[1 0 0 0 0 ��d-1)
%                    1 0 0 0 0
%                    1 12 0 0 0
%                    1 12 0 0 0
%                    1 12 3 0 0
%                    1 11 1 0 0]

%�Ӧ�0��������4��һ���������
%��ʼ������-1�ͦ�0��ϵ������[1,0,0,0,0]
SigmaCalc(1,1) = 1; 
SigmaCalc(2,1) = 1;
%����ϵ������Ҫ�ж��Ƿ�Ϊ0,ע�������������Ǵ�-1��ʼ�ģ�������Ҫ-2������-1
d = [1,SyndromCalc(1,1),0,0,0,0];
%��������
Deg = [0,0,0,0,0,0];
%����4�ηֱ��������1����4
for j = 3:1:6
    if (d(1,j-1)==0)
        SigmaCalc(j,:) = SigmaCalc(j-1,:);
        %d(1,j) = d(1,j-1);
        Deg(1,j) = Deg(1,j-1);
    else
        %����Ѱ�ҷ���������i,i<j�� di!=0 ��i- D(i)���
        min_ = -10000;
        i=0;
        for s = j-2 :-1:1
            if( d(1,s)~=0 && (s-Deg(1,s)>min_) )
                min_ = s-Deg(1,s);
                i = s; 
            end
        end;
        % x^(j-i)*��(i)(x)
        for tt = 1:1:5
            if tt+j-i >5
                break;
            end
            SigmaCalc(j,tt+j-i-1) = SigmaCalc(i,tt);
        end
        %��λ����0
        for tt = 1:1:j-i-1
            SigmaCalc(j,tt) = 0;
        end;
        %dj*di-1
        temp = RsSymbolMul(d(1,j-1),RsSymbolRev(d(1,i)));
        %dj*(di^-1)*x^(j-i)*��(i)(x)
        for tt = 1:1:5
            SigmaCalc(j,tt) = RsSymbolAdd(SigmaCalc(j-1,tt),RsSymbolMul(temp,SigmaCalc(j,tt))); 
        end;
        %�����deg
        for tt = 5:-1:1
            if(SigmaCalc(j,tt)~=0)
                Deg(1,j) = tt-1; %����
                break;
            end
        end;
    end;
    %��dj,j=6��ʱ������
    if j==6
       break;
    end
    temp_d = SyndromCalc(1,j-1);
    for tt = 1:1:Deg(1,j)
        temp_d = RsSymbolAdd(temp_d,RsSymbolMul(SyndromCalc(1,j-1-tt),SigmaCalc(j,tt+1))); 
    end;
    d(1,j) = temp_d;
end;
%ȡ2~6����Ϊ�������
SigmaRet = SigmaCalc(2:6,:);
%ȡ���һ����Ϊ����λ�ö���ʽ
ErrPosPolyCalc = SigmaCalc(6,:);
end

