function [objRow, z, Xb, Binv, Cb, basicVars] = compute (A, b, c, Xb, n, Binv, Cb, objRow, basicVars)

%% Finds pivot column
pivColNum = 1;
[~,m] = size(objRow);
for i = 1:m
    val = objRow(i);
    if (val < objRow(pivColNum))
        pivColNum = i;
    end
end

pivCol = Binv*A(:,pivColNum);

%% Finds departing variable
thetaRatios = zeros(1,n);

for k=1:n
    if (pivCol(k) > 0)
        pivRowNum = k;
        break;
    end
    if (k==n)
        % If all entries in the pivot column are non-positive, then there
        % is an unbounded solution.
        error('Solution is unbounded.');
    end
end

for j = 1:n
    thetaRatios(j) = Xb(j)/pivCol(j);
    val2 = thetaRatios(j);
    if (val2 >= 0) && (val2 < thetaRatios(pivRowNum))
        pivRowNum = j;
    end
end

pivVal = pivCol(pivRowNum);

%% Updates basic variables
basicVars(pivRowNum) = pivColNum;

%% Updates Cb
Cb(pivRowNum) = c(pivColNum);

%% Builds n-vector
nVector = zeros(n,1);

for k = 1:n
    if (k==pivRowNum)
        nVector(k) = 1/pivVal;
    else
        nVector(k) = -pivCol(k)/pivVal;
    end
end

%% Builds E matrix
e = eye(n);
e(:,pivRowNum) = nVector;

%% Updates Binv
Binv = e*Binv;

%% Updates z, Xb, and obj row
temp = cat(2,1,Cb'*Binv);
[x,y] = size(Binv);
temp2 = zeros(x,y+1);
temp2(:,2:end) = Binv;

Minv = cat(1,temp,temp2);
temp3 = cat(1,0,b);
finalArray = Minv*temp3;

z = finalArray(1);
Xb = finalArray(2:end);
objRow = [1, Cb'*Binv] * [-c'; A];

