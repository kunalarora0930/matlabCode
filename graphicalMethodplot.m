clc;

% input
n = input("input number of variables: ");
A = input("input coefficients: ");
B = input("input constants: ");
C = input("input C: ");

% plotting graph
y1 = 0:max(B);
x21 = (B(1) - A(1,1).*y1)./A(1,2);
x22 = (B(2) - A(2,1).*y1)./A(2,2);
% x23 = (B(3) - A(3,1).*y1)./A(3,2);

plot(y1, x21, 'r', y1, x22, 'b');
xlabel('Value of x1');
ylabel('Value of x2');
