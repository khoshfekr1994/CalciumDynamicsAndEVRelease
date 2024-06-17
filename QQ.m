function g = QQ(d)
% Release function

u = 11.3; % s^-1, release slope
s = 977; % mu M/ms, release function parameter
%s = 90 - 110.*u;

if d<50 
    f=0;
elseif d < 115 && d>50
    f = d - 50;
elseif d > 115
    f = u.*d + s;
end
g = f.*1e-3;

end