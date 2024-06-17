%% The simulations of the EVs release rate from submembrane and LTCC
% microdomains, and the cumulative EVs release rate as functions of time
% for different values of heart rates ranging from 60 bpm to 120 bpm by
% considering no control signal (Jcontrol = 0) to observe the natural
% EVs release mechanism.
% The EVs release profile from the submembrane and LTCC microdomains,
% and the cumulative EVs release profile as functions of time for
% different heart rates ranging from 60 bpm to 120 bpm by considering
% no control signal.
clear
TT = [60./60,60./80,60./100,60./120];  % pacing period
n = length(TT); % number of periods
for j=1:n
    global T;
    T = TT(j);
    %% Calcium cycling
    dx = 1./3000; % numerical integral duration
    c0 = [.17;0.09;10;2.5e-5;5;0;0;.17]; % initial values 
    [t,c]=ode45(@diff_ca_eqs,linspace(0,3,1./dx),c0); % calcium dynamics
    for i=1:length(t)
        R_LTCC(j,i) = R_ca_L(c(i,8),c(i,1),t(i),T); % EVs from LTCC
        R_sub_membrane(j,i) = R_ca_m(c(i,1)); % EVs from submembrane space
        EV_sub_membrane(j,i) = sum(dx.*R_sub_membrane(j,:)); % Numerical integral
        EV_LTCC(j,i) = sum(dx.*R_LTCC(j,:)); % Numerical integral
 end
    EV_rate(j,:) = R_sub_membrane(j,:)+R_LTCC(j,:);
end


color2=[0 0.4470 0.7410];
color1 = [0.8500 0.3250 0.0980];
color3=[0.9290 0.6940 0.1250];
color4=[0.4940 0.1840 0.5560];
figure(8)
subplot(2,4,1)
semilogy(t,R_sub_membrane(1,:),'LineWidth',2,'color',color1)
hold on
semilogy(t,R_LTCC(1,:),'LineWidth',2,'color',color2)
semilogy(t,R_sub_membrane(1,:)+R_LTCC(1,:),'LineWidth',2,'color',color3)
xlabel('{\it t} (s)')
ylabel('EVs release rate')
legend('\gamma_{s}','\gamma_{LTCC}','\gamma','location','southeast')
title('60 bpm')
ylim([0.001,0.02])

subplot(2,4,2)
semilogy(t,R_sub_membrane(2,:),'LineWidth',2,'color',color1)
hold on
semilogy(t,R_LTCC(2,:),'LineWidth',2,'color',color2)
semilogy(t,R_sub_membrane(2,:)+R_LTCC(2,:),'LineWidth',2,'color',color3)
xlabel('{\it t} (s)')
ylabel('EVs release rate')
legend('\gamma_{s}','\gamma_{LTCC}','\gamma','location','southeast')
title('80 bpm')
ylim([0.001,0.02])

subplot(2,4,3)
semilogy(t,R_sub_membrane(3,:),'LineWidth',2,'color',color1)
hold on
semilogy(t,R_LTCC(3,:),'LineWidth',2,'color',color2)
semilogy(t,R_sub_membrane(3,:)+R_LTCC(3,:),'LineWidth',2,'color',color3)
xlabel('{\it t} (s)')
ylabel('EVs release rate')
legend('\gamma_{s}','\gamma_{LTCC}','\gamma','location','southeast')
title('100 bpm')
ylim([0.001,0.02])

subplot(2,4,4)
semilogy(t,R_sub_membrane(4,:),'LineWidth',2,'color',color1)
hold on
semilogy(t,R_LTCC(4,:),'LineWidth',2,'color',color2)
semilogy(t,R_sub_membrane(4,:)+R_LTCC(4,:),'LineWidth',2,'color',color3)
xlabel('{\it t} (s)')
ylabel('EVs release rate')
legend('\gamma_{s}','\gamma_{LTCC}','\gamma','location','southeast')
title('120 bpm')
ylim([0.001,0.02])

subplot(2,4,5)
semilogy(t,EV_sub_membrane(1,:),'LineWidth',2,'color',color1)
hold on
semilogy(t,EV_LTCC(1,:),'LineWidth',2,'color',color2)
semilogy(t,EV_sub_membrane(1,:)+EV_LTCC(1,:),'LineWidth',2,'color',color3)
xlabel('{\it t} (s)')
ylabel('EVs release profile')
legend('\Gamma_{s}','\Gamma_{LTCC}','\Gamma','location','southeast')
title('60 bpm')
ylim([0.000001,0.02])

subplot(2,4,6)
semilogy(t,EV_sub_membrane(2,:),'LineWidth',2,'color',color1)
hold on
semilogy(t,EV_LTCC(2,:),'LineWidth',2,'color',color2)
semilogy(t,EV_sub_membrane(2,:)+EV_LTCC(2,:),'LineWidth',2,'color',color3)
xlabel('{\it t} (s)')
legend('\Gamma_{s}','\Gamma_{LTCC}','\Gamma','location','southeast')
ylabel('EVs release profile')
title('80 bpm')
ylim([0.000001,0.02])

subplot(2,4,7)
semilogy(t,EV_sub_membrane(3,:),'LineWidth',2,'color',color1)
hold on
semilogy(t,EV_LTCC(1,:),'LineWidth',2,'color',color2)
semilogy(t,EV_sub_membrane(3,:)+EV_LTCC(3,:),'LineWidth',2,'color',color3)
xlabel('{\it t} s)')
ylabel('EVs release profile')
legend('\Gamma_{s}','\Gamma_{LTCC}','\Gamma','location','southeast')
title('100 bpm')
ylim([0.000001,0.02])

subplot(2,4,8)
semilogy(t,EV_sub_membrane(4,:),'LineWidth',2,'color',color1)
hold on
semilogy(t,EV_LTCC(2,:),'LineWidth',2,'color',color2)
semilogy(t,EV_sub_membrane(4,:)+EV_LTCC(4,:),'LineWidth',2,'color',color3)
xlabel('{\it t} (s)')
legend('\Gamma_{s}','\Gamma_{LTCC}','\Gamma','location','southeast')
ylabel('EVs release profile')
title('120 bpm')
ylim([0.000001,0.02])