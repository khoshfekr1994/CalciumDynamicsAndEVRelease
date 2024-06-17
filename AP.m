function f=AP(t,T)
% action potential in m^th beat
% T is the pacing cycle length

v_min = -80e-3; % V 
v_max = 30e-3;  % V 
X = 2/3 ./(2/3 + T);

m = floor(t./T); % finding the m^th beat at time t

if le(m.*T,t) && le(t,(m+X).*T) 
    f = v_min + (v_max - v_min) .* sqrt(1 - ((t-m.*T)./(X.*T)).^2);
else 
    f = v_min;
end
end