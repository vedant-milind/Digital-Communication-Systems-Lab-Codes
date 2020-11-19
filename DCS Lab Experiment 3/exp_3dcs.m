clc
m = input('Enter The Degree of the Polynomial: ');
a = zeros(1,m+1);
for i = 0:1:m
    if(i == 0)
        a(1,i+1) = input('Enter the value of constant: ');
        continue;
    end
    fprintf('Enter the coefficient of x^%d: ',i);
    a(1,i+1) = input('');
end
f = gfprimck(a);
if(f == 1)
    fprintf('The given Polynomial is Primitive \n');
elseif(f == 0)
    fprintf('The given Polynomial is Irreducible but not Primitve \n');
else
    fprintf('The given Polynomial is Reducible \n');
end
