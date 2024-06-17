function f = I_ca_L(t,d_L,f_L)
% input: t = time
% output: L-type calcium channel current ()

global T;
v = AP(t,T);
g_ca_L = 0.052709184;
E_ca_L = 46.4; % mV
f = g_ca_L .* ( d_L .* f_L + (0.006)./( 1 + exp( -(v + 14.1) ./6 ) )  ) .* (v - E_ca_L);