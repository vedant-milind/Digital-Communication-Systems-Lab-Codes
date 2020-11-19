clc;
clear;
while 1
    n=input("Enter codeword length n: ");
    k=input("Enter message length k: ");
 
    if n<k
        disp("n should be greater than k, Please re-enter!")
        continue;
    else
        pol=cyclpoly(n,k);
        disp("Coefficient Matrix for Generator Polynomial (n,k) Cyclic Code: ");
        disp(pol);
        g=poly2sym(pol);
 
        disp("Generator Polynomial g(x) : ");
        disp(g);
        break;
    end
end
