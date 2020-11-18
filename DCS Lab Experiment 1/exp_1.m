clc;
n =7;
k =4;
g=zeros(k,n);
m=zeros(1,k);
p=zeros(k,n-k);
pT=zeros(n-k,k);
h=zeros(n-k,n);
m = input('Enter message the sequence for (7,4) (in the form [x,x,x,x]):');
for i=1:1:k
    for j=1:1:n
        if(i==j)
            g(i,j)=1;
        elseif(j>k && j<=(n+1-i))
            g(i,j)=1;
        elseif(i==k && j==n)
            g(i,j)=1;
        else
            g(i,j)=0;
        end   
    end
end
g(1,5)=1;
g(1,6)=0;
g(1,7)=1;
g(2,5)=1;
g(2,6)=1;
g(2,7)=1;
g(3,5)=1;
g(3,6)=1;
g(3,7)=0;
g(4,5)=0;
g(4,6)=1;
g(4,7)=1;

for i=1:1:k
    for j=1:1:n-k
        p(i,j)=g(i,j+k);
    end
end
pT=transpose(p);

for i=1:1:n-k
    for j=1:1:n
        if(j<=4)
            h(i,j)=pT(i,j);
        elseif(i+4==j)
            h(i,j)=1;
        else
            h(i,j)=0;
        end
    end
end
c=m*g;
for i=1:1:n
    if(mod(c(i),2) == 0)
        c(i)=0; 
    else
        c(i)=1;
    end
end
disp("G(Generator) matrix");
disp(g);
disp("P(Parity) matrix");
disp(p);
disp("H(Parity-Check) matrix");
disp(h);
disp("Codeword");
disp(c);

k=input("Select a position to flip the bit in received code : ");
if(c(k)==0)
    c(k)=1;
else
    c(k)=0;
end

r=c;
disp("Codeword with error at 1 bit");
disp(r);

H=transpose(h);
    S=mod(r*H,2);
    disp(S);
    if S == [0 0 0]
        disp ("Recieved Code Without Error");
    else
        ErrPos =1;
        for i=1:1:n
            d=[h(:,ErrPos)];
            d=d';
            if((d(1)==S(1)) && (d(2)==S(2)) && (d(3)== S(3)))
                break;
            else
                ErrPos=ErrPos +1;
            end
        end
        disp("Error at bit:");
        disp(ErrPos)
        if(r(ErrPos) == 0)
            r(ErrPos) = 1;
            disp("The Codeword is restored by flipping the error bit");
            disp(r);
        else
            r(ErrPos) = 0;
            disp("The Codeword is restored by flipping the error bit");
            disp(r);
        end
    end
