function y=predYuni(x,btabla,ctabla,wtabla,tabla,btablaloc,btablavis,ctablaloc,ctablavis)
        mdd=zeros(1,size(tabla,1));
for i=1:15
        w=wtabla(i);
        mj=zeros(1,size(tabla,2));
            tij=tabla(i,1);
            b=btabla(tij);
            c=ctabla(tij);
            mj(1)=membresia(x(1),b,c);
            tij=tabla(i,2);
            b=btabla(tij);
            c=ctabla(tij);
            mj(2)=membresia(x(2),b,c);
            tij=tabla(i,3);
            b=btablaloc(tij);
            c=ctablaloc(tij);
            mj(3)=membresia(x(3),b,c);
            tij=tabla(i,1);
            b=btablavis(tij);
            c=ctablavis(tij);
            mj(4)=membresia(x(4),b,c);
        
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