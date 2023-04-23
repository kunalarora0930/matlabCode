close all;
clc;

n = 2;
M = 10000;
c = [-2 -1 0 0 -M -M];
a1 = [3 1 0 0 1 0; 4 3 -1 0 0 1; 1 2 0 1 0 0];
b = [3; 6; 3];
% s = eye(size(a1,1));

a = [a1 b]
cost = zeros(1,size(a,2));
cost(1:6) = c;
bv = [5 6 4]

zjcj = cost(bv) * a - cost
simplexTable = [zjcj; a];

table = array2table(simplexTable);
table.Properties.VariableNames(1:end) = {'x1', 'x2', 's2', 's3', 'A1', 'A2', 'sol'};
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
    currentbfs.Properties.VariableNames(1:end) = {'x1', 'x2', 's2', 's3', 'a1', 'a2', 'sol'};
    fprintf("The current bfs is");
    currentbfs

end

fprintf("This is the optimal solution :)");