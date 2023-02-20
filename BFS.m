c = [1 2 0 0];
A = [-1 1 1 0; 1 1 0 1];
b = [1; 2];

m = size(A, 1);
n = size(A, 2);

if n >= m
    nv = nchoosek(n, m);
    t = nchoosek(1:n, m);
    sol = [];

    for i = 1:nv
        y = zeros(n, 1);
        B = A(:, t(i, :));
        x = B \ b;

        if all(x >= 0 & x ~= inf & x ~= -inf)
            y(t(i, :)) = x;
        end

        sol = [sol y];
    end

end

Z = c * sol;
[Zmax, Zind] = max(Z);
BFS_ = sol(:, Zind);
BFS_ = BFS_';
sol
BFS_
