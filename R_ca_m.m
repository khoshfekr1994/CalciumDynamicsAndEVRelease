function f = R_ca_m(cs)
% Release rate for sub-membrane
% cs is the calcium concentration in sub-membrane space

k_m = 2e-6;
n_m = 2;

cs = cs.*1e-6; % converting to mu

f = f_h(cs,k_m,n_m);

end