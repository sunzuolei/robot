function F = jacobF(X, u)
theta = X(3);
dx    = u(1);
dy    = u(2);
F = [1,  0, - dy*cos(theta) - dx*sin(theta);
     0,  1,   dx*cos(theta) - dy*sin(theta);
     0,  0,                               1];
end