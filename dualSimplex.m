% close all;
% clc;

% n = 2;
% c = [-2 0 -1 0 0 0];
% a1 = [-1 -1 1; -1 2 4];
% b = [-5; -8];
% s = eye(size(a1,1));

% a = [a1 s b];
% cost = zeros(1,size(a,2));
% cost(1:6) = [-2 0 -1 0 0 0];
% bv = [4 5];

% zjcj = cost(bv) * a - cost
% simplexTable = [zjcj; a];

% table = array2table(simplexTable);
% table.Properties.VariableNames(1:end) = {'x1', 'x2', 'x3', 's1', 's2', 'sol'};
% disp(table);

% sol = a(:,end);

% while any(sol < 0)
%     fprintf("The current table is not feasible :(");
%     bv;


%     % find leaving variable
%     [leaving_var, pvt_row] = min(sol);
%     row = a(pvt_row, 1:end-1);
    
%     % find entering var
%     zc = zjcj(:, end - 1);
%     ratio = zeros(1,size(zc, 2));
%     for i = 1 : size(zc, 2)
%         if row(i) < 0
%             ratio(i) = abs(zc(i)./row(i));
%         else
%             ratio(i) = inf;
%         end
%     end

%     [minVal, pvt_col] = min(ratio);




    
%     % update pivot row
%     a(pvt_row, :) = a(pvt_row, :)/a(pvt_row,pvt_col);


%     % update table for next iteration
%     for i = 1 : size(a,1)
%         if i ~= pvt_row
%             a(i, :) = a(i,:) - a(i,pvt_col).*a(pvt_row,:);
%         end
%     end

%     zjcj = zjcj - zjcj(pvt_col).*a(pvt_row,:);
%     zc = zjcj(1:end-1);
%     [zjcj; a]
    
%     bfs = zeros(1,size(a,2));

%     bfs(bv) = a(:,end)
%     bfs(end) = sum(bfs.*cost)
%     currentbfs = array2table(bfs);
%     currentbfs.Properties.VariableNames(1:end) = {'x1', 'x2', 'x3', 's1', 's2', 'sol'};
%     fprintf("The current bfs is");
%     currentbfs
%     sol = a(:,end)

% end

% fprintf("This is the optimal solution :)");


clc
clear all
variables = {'x1', 'x2', 'x3', 's1', 's2', 'sol'};
cost = [-2, 0, -1, 0, 0, 0];
info = [-1, -1, 1; -1, 2, -4];
b = [-5; -8];

s = eye(size(info, 1));
a = [info s b];

bv = [4 5];

fprintf('basic variable (bv) =');
disp(variables(bv));

zjcj = cost(bv) * a - cost;
zcj = [zjcj; a];
simplexTable = array2table(zcj);
simplexTable.Properties.VariableNames(1:size(zcj, 2)) = variables

run = true;

while run
    sol = a(:, end);

    if any(sol < 0);
        fprintf('current bfs not feasible\n');
        [leaving_val, pvt_row] = min(sol);
        fprintf("\nleaving variable: %d", pvt_row)
        row = a(pvt_row, 1:end - 1);
        zj = zjcj(:, 1:end - 1);

        for i = 1:size(row, 2)

            if row(i) < 0
                ratio(i) = abs(zj(i) ./ row(i));
            else
                ratio(i) = inf;
            end

        end

        [minval, pvt_col] = min(ratio);
        fprintf('\nentering variablle = %d\n', pvt_col);
        bv(pvt_row) = pvt_col;
        fprintf('basic variablle (bv) =')
        disp(variables(bv));

        pvt_key = a(pvt_row, pvt_col);
        a(pvt_row, :) = a(pvt_row, :) ./ pvt_key;

        for i = 1:size(a, 1)

            if i ~= pvt_row
                a(i, :) = a(i, :) - a(i, pvt_col) .* a(pvt_row, :);
            end

        end

        zjcj = cost(bv) * a - cost;

        zcj = [zjcj; a];
        simplexTable = array2table(zcj);
        simplexTable.Properties.VariableNames(1:size(zcj, 2)) = variables

    else
        run = false;
        fprintf('current bfs feasible and optimal \n');
    end

end
