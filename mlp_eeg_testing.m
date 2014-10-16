clear all;
close all;
% inp=zeros(1,800);
% inp(:)=50;
s=serial('com1');
fopen(s);
s.ReadAsyncMode='manual';
xx=load('testsamplesforw');
for ii=1:10
    inp=xx.inpset(ii,:);
    data=load('weightsfortrial.mat');
    hidunits=12;
    inpunits=12;
    wih1=data.wih1;
    wh1h2=data.wh1h2;
    wh2h3=data.wh2h3;
    wh3o=data.wh3o;
    op=[-1 -1 -1 -1 -1];
    bh1=data.bh1;
    bh2=data.bh2;
    bh3=data.bh3;
    bop=data.bop;


    h1=zeros(1,hidunits);
    h2=zeros(1,hidunits);
    h3=zeros(1,hidunits);

    for i=1:hidunits
        for j=1:inpunits
            h1(i)=h1(i)+wih1(i,j)*inp(j);
        end
        if h1(i)<bh1(i)
            h1(i)=-1;
        else
            h1(i)=1;
        end
    end

    for i=1:hidunits
        for j=1:hidunits
            h2(i)=h2(i)+wh1h2(1,j)*h1(j);
        end
         if h2(i)<bh2(i)
            h2(i)=-1;
        else
            h2(i)=1;
        end
    end

    for i=1:hidunits
        for j=1:hidunits
            h3(i)=h3(i)+wh2h3(1,j)*h2(j);
        end
         if h3(i)<bh3(i)
            h3(i)=-1;
        else
            h3(i)=1;
        end
    end

    for i=1:5
        for j=1:inpunits
            op(i)=op(i)+wh3o(i,j)*h3(j);
        end
         if op(i)<=bop(i)
            op(i)=-1;
        else
            op(i)=1;
         end
    end
    op
    if op(1)==1 && op(2)==-1 && op(3)==-1 && op(4)==-1 && op(5)==-1
        fwrite(s,49,'%d');
    else if op(1)==-1 && op(2)==-1 && op(3)==-1 && op(4)==-1 && op(5)==1
            fwrite(s,50,'%d');
        end
    end    
end
fclose(s);
delete(s);
