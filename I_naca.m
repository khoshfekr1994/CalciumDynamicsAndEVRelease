function f=I_naca(cs,t,T)
% The sodium calcium exchange current given in Luo-Rudy II


I_naca_bar= 200; % mu M/s Adjustable strength of exchanger
K_m_na = 87.5; % mM, Luo-Rudy II constant
Na_o = 140; % mM, External sodium concentration
K_m_ca = 1.38; % mM, Luo-Rudy II constant
Ca_o = 1.8; % mM, External calcium concentration
zita = 0.35; % Luo-Rudy II constant
F = 9.65e4; % Faraday constant
R = 8.314; % J mol^-1 K^-1, Universal gas constant
Temp = 308; % ^o Kelvin
k_sat = 0.1; % Luo-Rudy II constant
Na_i = 129.4632./(1 + 12.4857.*sqrt(T));
a = AP(t,T).* F./(R.*Temp);
f = I_naca_bar .* 1./(K_m_na.^3 + Na_o^3) .* 1./(K_m_ca + Ca_o) ...
     .* ((exp(zita.*a)) .* Na_i.^3 .* Ca_o - exp((zita-1).*a) .*...
     Na_o.^3 .*cs)./(1 + k_sat .* exp((zita-1).*a));
end