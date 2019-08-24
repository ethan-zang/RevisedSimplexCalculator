function [optVal, basis, basicVars] = main(A,b,c)
A = [2 -1 3; 1 3 5; 2 0 1];
b = [6; 10; 7];
c = [2; 1; 3];
%% DESCRIPTION
% This program uses the "main.m" function to compute the solution to the
% given LPP. "Compute.m" completes one iteration of the revised simplex
% method. "Main.m" checks the objective row of the problem and calls
% "compute.m" each time there is one or more negative value in the
% objective row, until the objective row is all positive or there is no
% finite solution.

% TO USE THIS SOLVER, ENTER "[optVal, basis, basicVars] = main(A,b,c,n)"
% INTO THE COMMAND WINDOW, WHERE A IS THE COEFFICIENT MATRIX, b IS THE
% COLUMN VECTOR OF CONSTANTS, c IS THE COLUMN VECTOR OF COST COEFFICIENTS,
% AND n IS THE NUMBER OF BASIC VARIABLES. NEEDED VALUES ARE ROUNDED TO 4
% DECIMAL PLACES.

% Note: This solver solves the standard form problem Max z = c1*x1 + c2x2 +
% c3x3... subject to Ax <= b, where b>=0 and all x>=0.

% The solution will be printed in the command window with:
% 1. The optimal value
% 2. The values of the basic variables
% 3. The corresponding basic variable numbers 

%% EXAMPLE OUTPUT
% optVal =

%    9.3334


% basis =

%    0.3333
%    1.6667
%    3.3333


% basicVars =

%     3     2     1

% This corresponds to an optimal value of 9.3334 which occurs at a basis of
% x3 = 0.3333, x2 = 1.6667, x1 = 3.3333.

%% CODE BEGINS HERE
% Initializes values needed
[m,k] = size(A);
A = [A, eye(m)];

c = [c', zeros(1,m)]';
Xb = b;
z = 0;
Cb = c(end-m+1:end);

% Initializes basic variables
basicVars = zeros(1,m); % basicVars = n+1:n+m;
for i=1:m
    basicVars(i) = k+i-m;
    
end

% Checks that b is >= 0
[length,~] = size(b);
for s = 1:length
    if (b(s) < 0)
        error('One or more value in b is not greater than or equal to 0. Please fix.');
    end
end

% Computes obj row for first iteration
Binv = A(1:m,k-m+1:k);
objRow = [1, Cb'*Binv] * [-c'; A];

% Computes obj row again if there is a negative value in obj row until the
% obj row is all positive
while (any(objRow<0))
    [objRow, z, Xb, Binv, Cb, basicVars] = compute(A, b, c, Xb, m, Binv, Cb, objRow, basicVars);
    
    % Rounds the obj row, Xb, and Binv to 5 decimal places.
    for i=1:k
        objRow(i) = round(objRow(i),5);
    end
    for j=1:m
        Xb(j) = round(Xb(j),5);
    end
    for r=1:m
        for s=1:m
            Binv(r,s) = round(Binv(r,s),5);
        end
    end
end

% Sets optimal value and basis
optVal = z;
basis = Xb;
return

