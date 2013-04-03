function Ym = numeroaMatriz(y)

mx=max(y);
Ym=zeros(mx,size(y,2));

for i=1:size(y,2)
   Ym(y(i),i)=1; 
    
end



end