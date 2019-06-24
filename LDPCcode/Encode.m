function sendcode = Encode( s , Hst )%�ڶ������������Ѿ�ת�úõĲ�����������
%ENCODE Summary of this function goes here
%   Detailed explanation goes here

  x = s * Hst; %s��1x1008����
  x = mod(x,2);
  p = zeros(1,1008);
  for bias = 1:1:56
      for ii = 1:1:18
          pos = bias + (ii-1)*56; %��ǰ������λ��
          if pos == 1
              p(1,pos) = x(1,pos);
          elseif pos >1 && pos <=56
              p(1,pos) = add(x(1,pos),p(1,17*56+pos-1));
          else
              p(1,pos) = add(x(1,pos),p(1,pos-56));
          end;
                  
          
      end
  end
  
  sendcode = [p,s];

end

function ret = add(a,b)
    if a~=b
        ret = 1;
    else
        ret = 0;
    end;
end