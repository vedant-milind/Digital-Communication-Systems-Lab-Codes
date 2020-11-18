clc

n = input("enter the value of n "); %user input 
m = 2:n-1; %Setting the value of G from 0 to n-1

fprintf("The elements of set of mod-%.0f are: ", n); 
disp(m); %For displaying all the elements of the set

fprintf("The primitive elements for mod-%.0f are: ", n)
elements = m(isPrimitiveRoot(m,n));
disp(elements); %To Display Only the Primitive Elements