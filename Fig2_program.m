clc
clear
close all

% Case 1
alpha = 2; 
N_step = 30; 
d_ = linspace(0, 3, N_step)'; 
BGT_area_alpha2 = zeros(N_step, 1); 
BGT_load_alpha2 = zeros(N_step, 1); 
for i = 1: N_step
    i
    [BGT_area_alpha2(i), BGT_load_alpha2(i)] = BGT_simplified(alpha, d_(i), [50; 50; 50]); 
end

% Case 2
alpha = 10; 
N_step = 30; 
BGT_area_alpha10 = zeros(N_step, 1); 
BGT_load_alpha10 = zeros(N_step, 1); 
for i = 1: N_step
    i
    [BGT_area_alpha10(i), BGT_load_alpha10(i)] = BGT_simplified(alpha, d_(i), [50; 50; 50]); 
end

figure; 
hold on
plot(BGT_load_alpha2, BGT_area_alpha2, 'r-', 'LineWidth', 2); 
plot(BGT_load_alpha10, BGT_area_alpha10, 'b-', 'LineWidth', 2); 
plot(BGT_load_alpha2, BGT_load_alpha2*sqrt(pi/2), 'k--', 'LineWidth', 2); 
hold off
xlabel('Contact ratio A^*'); 
ylabel('Dimensionless pressure'); 
legend('alpha = 2', 'alpha = 10', 'Asymptotic BGT');

save('Fig2_data.mat', 'BGT_load_alpha2', 'BGT_area_alpha2', 'BGT_load_alpha10', 'BGT_area_alpha10'); 