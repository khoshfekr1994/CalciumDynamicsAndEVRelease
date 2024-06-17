function f=Betta(c)
% The buffering to SR membrane and calmodulin binding sites

B_sr = 47; % mu mol / l cytosol
B_cd = 24; % mu mol / l cytosol
K_sr = 0.6; % mu M
K_cd = 7; % mu M
f = 1./(1 + (B_sr.*K_sr)./(c + K_sr).^2 + (B_cd.*K_cd)./(c + K_cd).^2);

end