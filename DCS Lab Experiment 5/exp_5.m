clc

%User Input for Code Word Length
n=input("Enter code word length n: ");

%User Input for message length
k=input("Enter message length k: ");

pol=cyclpoly(n,k); 
g=poly2sym(pol);

disp("Generator Polynomial g(x): ");
disp(g);