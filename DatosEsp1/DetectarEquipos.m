temp='0304%0405%0506%0607%0708%0809%0910%1011%1112%1213';
r=regexp(temp,'%','split');
%e=zeros(1,20);
e=cell(20);
for i=1:10
    s=strcat('SP',r(i),'.xlsx');
    s=char(s);
    
    [n,t,x]=xlsread(s);
    
    a=1;
    for j=1:10
        for k=3:4
            e(a)=t(j+1,k);
            a=a+1;
        end
    end
    fid = fopen(char(strcat('Equipos',r(i),'.txt')), 'wt');
    for aux=1:20
    fprintf(fid, '%s\n', e{aux});
    end
    fclose(fid);

end
