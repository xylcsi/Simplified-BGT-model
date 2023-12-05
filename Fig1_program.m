% Plot the contact area vs. load of different asperity contact model
clc
clear all
close all

global R1 R2

% Empirical solution: 
kappa_ratio = linspace(0, 1, 30); 
kappa_ratio = kappa_ratio(2:end); 
ba_fit = exp(0.006709*(log(kappa_ratio)).^2 + 0.6692*log(kappa_ratio)); 
      e = sqrt(1 - ba_fit.^2); 
    e1 = 1e-4: 0.01: 1-eps; 
[K, E] = ellipke(e1.^2); % Input of ellipke should be k^2
   ba1 = sqrt(1 - e1.^2); 
kappa_ratio_closed = (K - E)./(E./(1 - e1.^2) - K); % kappa_1/kappa_2

figure; 
hold on
plot(kappa_ratio, e, 'ro');
plot(kappa_ratio_closed, e1, 'b-');
hold off
xlabel('\kappa_1/\kappa_2'); 
ylabel('e'); 
legend('Closed-form solution', 'Curve-fit solution'); 

save('Fig1_data.mat', 'kappa_ratio', 'e', 'kappa_ratio_closed', 'e1'); 

[K, E] = ellipke(e.^2); % Input of ellipke should be k^2
kappa_ratio_closed = (K - E)./(E./(1 - e.^2) - K); % kappa_1/kappa_2
mean_rel_error = mean(abs(kappa_ratio_closed(1:end-1) - kappa_ratio(1:end-1))./...
                       kappa_ratio_closed(1:end-1)*100); 