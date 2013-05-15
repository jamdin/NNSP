function y=predY(x,btabla,ctabla,wtabla,tabla)
        mdd=zeros(1,size(tabla,1));
for i=1:15
        w=wtabla(i);
        mj=zeros(1,size(tabla,2));
        for j=1:size(tabla,2)
            tij=tabla(i,j);
            b=btabla(tij);
            c=ctabla(tij);
            mj(j)=membresia(x(j),b,c);
        end
        memband=min(mj);
       mdd(i)=w*memband;
end

md=zeros(1,5);
for i=1:5
    ind=3*(i-1)+1;
    md(i)=max(mdd(ind:(ind+2)));
end
    y_lim=[-5,-3,-1,1,3];
    y=encontrar_y(y_lim,md);
end