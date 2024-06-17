clear
% Extracellular Vesicles-mediated Bio-nano Communications in Heart 
% Intracellular Calcium signaling in Cardiomyocytes
TT = [60./60,60./80,60./100,60./120];%linspace(.5,2,n);  % pacing period
n = length(TT); % number of periods
cc2 = [];
cs_tilde = 0.5; % mu M, The calcium inactivation threshold
 for j=1:n
    global T;
    T = TT(j);
    %% Calcium cycling
    dx = 1./3000; % numerical integral duration
    c0 = [.17;0.09;10;2.5e-5;5;0;0;.17]; % initial values 
    [t,c]=ode45(@diff_ca_eqs,linspace(0,2*60,1./dx),c0); % calcium dynamics ODEs
    cc2(j,:) = c(:,2);
 end
%% The simulations of calcium concentration at the bulk myoplasm
%  space ([Ca2+]b) as a function of time for different heart rates ranging 
%  from 60 bpm to 120 bpm.

color2=[0 0.4470 0.7410];
color1 = [0.8500 0.3250 0.0980];
color3=[0.9290 0.6940 0.1250];
color4=[0.4940 0.1840 0.5560];

figure(10)
semilogy(t./60,cc2(1,:),'LineWidth',1.5,'color',color1)
hold on
semilogy(t./60,cc2(2,:),'LineWidth',1.5,'color',color2)
semilogy(t./60,cc2(3,:),'LineWidth',1.5,'color',color3)
semilogy(t./60,cc2(4,:),'LineWidth',1.5,'color',color4)
xlim([1 2])
legend('60 bpm','80 bpm','100 bpm','120 bpm')
xlabel('{\it t} (min)')
ylabel('[Ca^{2+}]_b (\muM)')
title('Bulk myoplasm calcium concentration')