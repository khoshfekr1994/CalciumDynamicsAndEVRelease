function f = I_trpn_s(cs)
% The amount of calcium in the sub-membrane that is bound to troponin C

B_sr = 47; % mu mol / l cytosol
B_cd = 24; % mu mol / l cytosol
K_sr = 0.6; % mu M
K_cd = 7; % mu M
k_on = 32.7; % (mu Ms)^-1, On rate for troponin C
k_off = 19.6; % (s)^-1, Off rate for troponin C
K_T = k_off./k_on;
B_T = 70; % mu mol/l cytsol, total concentration of troponin C
f = 1./(1 + (B_sr.*K_sr)./(cs + K_sr).^2 + (B_cd.*K_cd)./(cs + K_cd).^2 + (B_T.*K_T)./(cs+K_T).^2);

end