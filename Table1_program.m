clc
clear all
close all

alpha = 2; 
d_ = 0:0.5:3;
fprintf('alpha = 2: \n')
fprintf('d_       A_         sqrt(pi/2) p_bar_ \n');
for i = 1: 7
    [BGT_area, BGT_load] = BGT_simplified(alpha, d_(i), [50; 50; 50]); 
    BGT_load = sqrt(pi/2)*BGT_load; 
    fprintf('%g   %g   %g \n', d_(i), BGT_area, BGT_load); 
end

alpha = 10; 
fprintf('alpha = 10: \n')
fprintf('d_       A_         sqrt(pi/2) p_bar_ \n');
for i = 1: 7
    [BGT_area, BGT_load] = BGT_simplified(alpha, d_(i), [50; 50; 50]); 
    BGT_load = sqrt(pi/2)*BGT_load; 
    fprintf('%g   %g   %g \n', d_(i), BGT_area, BGT_load); 
end
