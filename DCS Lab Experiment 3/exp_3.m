clc
%An user input is taken for the degree of the polynomial
i = input('Enter the degree of polynomial: ');
z = zeros(1,i+1);

for i = 0:1:i %i goes from 0 to i with a step of 1
    if(i == 0)
        z(1,i+1) = input('Enter the constant: '); %user input for constant
                                                   %of the polynomial
        continue;
    end
    fprintf('Enter the coefficient of x^%d: ',i);
    z(1,i+1) = input('');
end
fprintf("In Polynomial Representation");
gfpretty(z);
f = gfprimck(z);
if(f == 1)
    fprintf('The polynomial is Primitive');
elseif(f == 0)
    fprintf('The polynomial is Irreducible but not Primitve');
else
    fprintf('The given Polynomial is Reducible, thus the polynomial cannot be primitve.');
end