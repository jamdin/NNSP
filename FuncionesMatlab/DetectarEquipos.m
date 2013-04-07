temp='0304%0405%0506%0607%0708%0809%0910%1011%1112%1213';
r=regexp(temp,'%','split');
e=cell(20);
paths=encontrarPaths;
path=paths{2};%paths{1} Espana
              %paths{2} Inglaterra
for i=1:10
    s=strcat(path, 'EP',r(i),'.xlsx');
    s=char(s);
    
    [n,t,x]=xlsread(s);
    
    a=1;
    for j=1:10
        for k=3:4
            e2=t(j+1,k);
%             esp=find(char(e2)==' ');      Sustituido por eliminarEspacios
%             e3=char(e2);
%             if size(esp,2)>0
% 
%                 for l=1:size(esp,2)
%                     
%                 r2=[e3(1:esp(l)-1),e3(esp(l)+1:end)];
%                 end
%             e3=r2;    
%             end
            e3=eliminarEspacios(e2);
            e(a)={e3};
            a=a+1;
        end
    end
    fid = fopen(char(strcat(path,'Equipos',r(i),'.txt')), 'wt');
    for aux=1:19
    fprintf(fid, '%s\n', e{aux});
    end
    fprintf(fid, '%s', e{aux+1});
    fclose(fid);

end
