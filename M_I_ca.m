function f=M_I_ca(cs,t,T)
% calcium current function
% cs is the calcium concentration in the sub-membrane space
% AP is the action potential function

%cs = c.*1e3;
cs_tilde = 0.5; % mu M, The calcium inactivation threshold
F = 9.65e4; % C/mol, Farady constant
R = 8.314; % J mol^-1 K^-1, Universal gas constant
Temp = 308; % Kelvin, Temprature
ca_o = 1.8; % mM, external calcium concentration
i_ca_bar = 25; % mu mol c^-1 cm^-1, adjustable proprotionality constant 
P_ca = 5.4e-4; % cm/s, constant defined in Luo-Roudy II
gam = 1;
V = AP(t,T);
d = (1+exp(-(V - 5)./(6.24))).^(-1); % instantaneous voltage dependent activation gate
ff = (1+exp((V+35)./(8.6))).^(-1); % slow voltage dependent inactivation gate variable
q = (1 + (cs./cs_tilde).^gam).^(-1); % calcium-induced inactivation
Po = d.*ff.*q; % open probability of the L-type channel

a = V.*F./(R.*Temp); % F=Faraday's constant, R= Universal gas constant, Temp= Temperature in Kelvin
M_i_ca = i_ca_bar .* P_ca .*4.*a.*F.*((cs .*exp(2.*a) - .341.*ca_o)./(exp(2.*a) -1));

% if t >100e-3 && t < 200e-3
%     x = -100;
% else
%     x = 0;
% end

f = M_i_ca; % calcium current I_ca

end