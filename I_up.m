function f = I_up(ci)
% The uptake current

v_up = 250; % mu M/s, uptake strenght
c_up = 0.5; % mu M, uptake threshold

f = (v_up .* ci.^2)./(ci.^2 + c_up.^2);
end