
clear all
clc
vectors=input("Enter the vectors in the form[v1;v2...;vn]")
rank=gfrank(vectors,2)
[m,n]=size(vectors)
if rank<m
    disp("The vectors are Linearly Dependent");
else
    disp("The vectors are Linearly Independent");  
end
