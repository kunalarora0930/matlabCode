clc;

cost = [11 20 7 8; 21 16 10 12 ; 8 12 18 9];


% supply
A = [50 40 70]; 

% demand
B = [30 25 35 40];

if sum(A) == sum(B)
    fprintf("The transport problem is balanced :)\n");
else
    fprintf("The transport problem is unbalanced :(\n");
    if sum(A) < sum(B)  % supply < demand
        % add dummy row
        cost(end+1, :) = zeros(1, size(cost, 2));
        A(end + 1) = sum(B) - sum(A);
    else
        % add dummy col
        cost(:, end + 1) = zeros(1, size(cost, 1));
        B(end + 1) = sum(A) - sum(B);
    end
end


cost
A 
B

icost = cost;
x = zeros(size(cost));
[m,n] = size(cost);

totalbfs = m+n-1;

for l = 1 : size(cost,1) * size(cost, 2)
    minCost = min(cost(:));
    [rowind, colind] = find(minCost == cost);
    x1 = min(A(rowind), B(colind));
    [val, ind] = max(x1);
    i = rowind(ind);
    j = colind(ind);
    y1 = min(A(i), B(j));
    x(i,j) = y1;
    A(i) = A(i) - y1;
    B(j) = B(j) - y1;
    cost(i,j) = inf;
end

bfs = array2table(x);

bfs

totalibfs = length(nonzeros(x));
totalibfs

if totalbfs ~= totalbfs
    fprintf("degenerate sol");
else
    fprintf("non-degenerate sol");
end

totalcost = sum(sum(x .* icost));

totalcost
