close all;
clc;

n = 3;
c = [-1 3 -2];
a1 = [3 -1 2; -2 4 0; -4 3 8];
b = [7; 12; 10];
s = eye(size(a1,1));

a = [a1 s b];
cost = zeros(1,size(a,2));
cost(1:n) = c;
bv = n + 1:1:size(a,2) - 1

zjcj = cost(bv) * a - cost
simplexTable = [zjcj; a];

table = array2table(simplexTable);
table.Properties.VariableNames(1:end) = {'x1', 'x2', 'x3', 's1', 's2', 's3', 'sol'};
disp(table);

zc = zjcj(1:end-1);

while any(zc < 0)
    fprintf("The current table is not optimal :(");
    bv;

    % find entering var
    % zc = zjcj(1:end-1);
    [ent_col, pvt_col] = min(zc);

    % find leaving variable
    sol = a(:,end)
    col = a(:,pvt_col)
    
    if all(col < 0)
        error('the lpp in infeasible :_(', A1);
    end
    ratio = zeros(1,n);
    for i = 1:size(col,1)
        if col(i) > 0
            ratio(i) = sol(i)/col(i);
        else ratio(i) = inf;
        end
    end
    % ratio

    [minratio, pvt_row] = min(ratio);
    pvt_col
    pvt_row
    lv = bv(pvt_row)
    bv(pvt_row) = pvt_col
    % update pivot row
    a(pvt_row, :) = a(pvt_row, :)/a(pvt_row,pvt_col);


    % update table for next iteration
    for i = 1 : size(a,1)
        if i ~= pvt_row
            a(i, :) = a(i,:) - a(i,pvt_col).*a(pvt_row,:);
        end
    end

    zjcj = zjcj - zjcj(pvt_col).*a(pvt_row,:);
    zc = zjcj(1:end-1);
    [zjcj; a]
    
    bfs = zeros(1,size(a,2));

    bfs(bv) = a(:,end)
    bfs(end) = sum(bfs.*cost)
    currentbfs = array2table(bfs);
    currentbfs.Properties.VariableNames(1:end) = {'x1', 'x2', 'x3', 's1', 's2', 's3', 'sol'};
    fprintf("The current bfs is");
    currentbfs

end

fprintf("This is the optimal solution :)");
