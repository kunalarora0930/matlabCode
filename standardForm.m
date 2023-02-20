format short;
clc;
A=[2 5 3];
b=[2 -7 4; 3 -4 5; 7 -8 9];
C=[5; 8; 10];

ineq=[0 1 1];

s = eye(size(b,1));   

index = find(ineq>0);

s(index,:) = -s(index,:);

objfn = array2table(A);
objfn.Properties.VariableNames(1:size(A,2)) = {'x 1', 'x 2','x 3'};

mat = [b s C];
constraint = array2table(mat);



constraint.Properties.VariableNames(1:size(mat,2)) = {'x 1', 'x 2','x 3','s 1','s 2','s 3','sol'};
objfn
constraint