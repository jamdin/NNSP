temp='0506%0607%0708%0809%0910%1011%1112%1213';
r=regexp(temp,'%','split');

paths=encontrarPaths;
path=paths{2};%paths{1} Espana
              %paths{2} Inglaterra

s=strcat(path,'Equipos',r(1),'.txt');
    s=char(s);
    C=textread(s,'%s');
    e=C;
    tam=size(C,1);
for i=2:size(r,2) %Todas las temporadas
    s=strcat(path,'Equipos',r(i),'.txt');
    s=char(s);
    C=textread(s,'%s');
    aux={};
    for j=1:size(C,1)
        b=estaEnArreglo(C(j),e);
        if b==0
            e(tam+1)=C(j);
            tam=tam+1;
        end
    end  
end

orden=sort(e);

 fid = fopen(char(strcat(path,'AllTeams.txt')), 'wt');
    for aux=1:size(orden)-1
    fprintf(fid, '%s\n', orden{aux});
    end
    fprintf(fid, '%s', orden{aux+1});
    fclose(fid);