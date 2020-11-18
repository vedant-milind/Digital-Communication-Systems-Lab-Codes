clc
n=input("Enter value of n: "); %user input for code word length
k=input("Enter value of k: "); %user inout for message length

poly = cyclpoly(n,k); % Generating a cyclic polynomial for (n,k)

disp("Coefficient Matrix for primitive polynomial (n,k) Cyclic Code is: ");
disp(poly);

symbolic_form =poly2sym(poly); 
disp("Primitive Polynomial for (n,k) Cyclic Code: ");
disp(symbolic_form);

[h,g] = cyclgen(n,poly,'nonsys'); %Displaying Non Systematic Form of Matrix
disp("Generator Matrix for (n,k) Cyclic Code in (Non-Systematic form): ");
disp(g);
disp("Parity-Check Matrix for (n,k) Cyclic Code in (Non-Systematic form): ");
disp(h);
G=mod(rref(g),2);
H=mod(rref(h),2);
disp("Generator Matrix for (n,k) Cyclic Code in (Systematic form): ");
disp(G)
disp("Parity-Check Matrix for (n,k) Cyclic Code in (Systematic form): ");
disp(H)