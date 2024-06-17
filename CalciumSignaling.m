%% The simulations of action potential (V) for different heart rates
% ranging from 60 bpm to 120 bpm as functions of time.
% The simulations of calcium concentration at submembrane space ([Ca2+]s)
% as a function of time for different heart rates ranging from 60 bpm to 120 bpm.
% The simulations of the calcium current (JCa) as a function of time for
% different heart rates ranging from 60 bpm to 120 bpm.
% The simulations of sodium-calcium exchange current (JNaCa) as a function
% of time for different heart rates ranging from 60 bpm to 120 bpm.

clear
TT = [60./60,60./80,60./100,60./120];%linspace(.5,2,n);  % pacing period
n = length(TT); % number of periods
cc1 = [];
cs_tilde = 0.5; % mu M, The calcium inactivation threshold
gam = 1;
for j=1:n
    global T;
    T = TT(j);
    %% Calcium cycling
    dx = 1./3000; % numerical integral duration
    c0 = [.17;0.09;10;2.5e-5;5;0;0;.17]; % initial values
    [t,c]=ode45(@diff_ca_eqs,linspace(0,1,1./dx),c0); % calcium dynamics
    cc1(j,:) = c(:,1);
    for i=1:length(t)
        I_ca2(j,i) = I_ca(c(i,1),t(i),T); % calcium current
        I_nc(j,i) = I_naca(c(i,1),t(i),T); % NaCa current
        V(j,i) = AP(t(i),T);
    end
end

%% plotting

color2=[0 0.4470 0.7410];
color1 = [0.8500 0.3250 0.0980];
color3=[0.9290 0.6940 0.1250];
color4=[0.4940 0.1840 0.5560];

figure(9)
subplot(2,2,1)
plot(1e3.*t,1e3.*V(1,:),'LineWidth',2,'color',color1)
hold on
plot(1e3.*t,1e3.*V(2,:),'LineWidth',2,'color',color2)
plot(1e3.*t,1e3.*V(3,:),'LineWidth',2,'color',color3)
plot(1e3.*t,1e3.*V(4,:),'LineWidth',2,'color',color4)
xlabel('{\it t} (ms)')
ylabel('{\it V} (mV)')
legend('60 bpm','80 bpm','100 bpm','120 bpm')
title('Action potential')

subplot(2,2,2)
plot(1e3.*t,cc1(1,:),'LineWidth',2,'color',color1)
xlabel('{\it t} (ms)')
ylabel('[Ca^{2+}]_s (\muM)')
hold on
plot(1e3.*t,cc1(2,:),'LineWidth',2,'color',color2)
plot(1e3.*t,cc1(3,:),'LineWidth',2,'color',color3)
plot(1e3.*t,cc1(4,:),'LineWidth',2,'color',color4)
title('Submembrane calcium concentration')

subplot(2,2,3)
plot(1e3.*t,I_ca2(1,:),'LineWidth',2,'color',color1)
xlabel('{\it t} (ms)')
ylabel('{\it J}_{Ca} (\muM/s)')
hold on
plot(1e3.*t,I_ca2(2,:),'LineWidth',2,'color',color2)
plot(1e3.*t,I_ca2(3,:),'LineWidth',2,'color',color3)
plot(1e3.*t,I_ca2(4,:),'LineWidth',2,'color',color4)
title('Calcium current')

subplot(2,2,4)
plot(1e3.*t,I_nc(1,:),'LineWidth',2,'color',color1)
xlabel('{\it t} (ms)')
ylabel('{\it J}_{NaCa} (\muM/s)')
hold on
plot(1e3.*t,I_nc(2,:),'LineWidth',2,'color',color2)
plot(1e3.*t,I_nc(3,:),'LineWidth',2,'color',color3)
plot(1e3.*t,I_nc(4,:),'LineWidth',2,'color',color4)
title('NaCa exchange current')
