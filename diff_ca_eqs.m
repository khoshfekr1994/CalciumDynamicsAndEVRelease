function dc = diff_ca_eqs(t,c)
% t is time

global T;
v_i = 1e-4; % mu l, cell volume
v_s = 0.1.*v_i; % sub-membrane volume
v = v_i./v_s;
tau_s = 10; % ms, submembrane diffusion time constant
tau_r = 20; %ms, spark life-time
g = 1.5e4; % sparks/muM, release current strength
tau_a = 50; % ms, relaxation time of cj' to cj
dc = zeros(8,1); % the number of ODEs is 5
k_on = 32.7; % (mu Ms)^-1, On rate for troponin C
k_off = 19.6; % (s)^-1, Off rate for troponin C
K_T = k_off./k_on;
B_T = 70; % mu mol/l cytsol, total concentration of troponin C
f = 0.01.*1e-6;
alpha = 5.180e-15; %mu mol pA-1 ms-1
vol_mu = 2.618e-17; %l
B_mu = 264; % ms-1
%% c_s
dc(1) = Betta(c(1)).*(v.*(c(4) - (c(1) - c(2))./(tau_s) - ...
    I_ca(c(1),t,T) + I_naca(c(1),t,T)) - dc(7)  );
dc(2) = Betta(c(2)) .* (    (c(1) - c(2))./(tau_s) - I_up(c(2))...
                        - dc(6)     );
dc(3) = -c(4) + I_up(c(2));
dc(4) = g.*I_ca(c(1),t,T).* QQ(c(5)) - c(4)./tau_r;
dc(5) = (c(3) - c(5))./(tau_a);
dc(6) = k_on.*c(2) .* (B_T - c(6)) - k_off.*c(6); % trpn i
dc(7) = k_on.*c(1) .* (B_T - c(7)) - k_off.*c(7); % trpn s
dc(8) = -f.*( alpha.*M_I_ca(c(1),t,T)./(vol_mu) - 1e-6.*B_mu.* (c(8) - c(1)) );

end