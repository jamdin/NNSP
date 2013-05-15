function tan=tablaANum(tabla)
tan=zeros(size(tabla));
[r,c]=find(strcmp(tabla,'BL'));
for i=1:size(r,1)
tan(r(i),c(i))=1;
end
[r,c]=find(strcmp(tabla,'SL'));
for i=1:size(r,1)
tan(r(i),c(i))=2;
end
[r,c]=find(strcmp(tabla,'D'));
for i=1:size(r,1)
tan(r(i),c(i))=3;
end
[r,c]=find(strcmp(tabla,'SW'));
for i=1:size(r,1)
tan(r(i),c(i))=4;
end
[r,c]=find(strcmp(tabla,'BW'));
for i=1:size(r,1)
tan(r(i),c(i))=5;
end



end
