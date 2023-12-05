function [area, load] = BGT_sub(x, y, z, d_, alpha)
% Inputs: 
% x = Transformed dimenisonless asperity height: x = exp(-xi_);
% y = Transformed dimensionless variable: y = kappa_1_/kappa_2_
% z = Transformed dimensionless curvature: z = exp(-kappa_2_)
%
     xi_ = -log(x); % Dimensionless asperity height
kappa_2_ = -log(z); % Dimensionless larger principal curvature 
kappa_1_ = y*kappa_2_; % Dimensionless smaller principal curvature 
      C1 = alpha/(2*alpha - 3); 

% PDF
Part1 = 27/8/pi*sqrt(C1)*exp(-C1*(xi_ - 3*(kappa_1_ + kappa_2_)/4/sqrt(alpha))^2); 
Part2 = kappa_1_*kappa_2_*(kappa_2_ - kappa_1_); 
Part3 = exp(-9/16*(kappa_1_^2 + kappa_2_^2 - 2/3*kappa_1_*kappa_2_)); 
  Phi = Part1*Part2*Part3; 

% Eccentricity
e = exp(0.006709*(log(kappa_1_/kappa_2_))^2 + 0.6692*log(kappa_1_/kappa_2_)); 
e = sqrt(1 - e^2); 
%
% Hertzian elliptic contact theory
% - Area
[K, E] = ellipke(e^2);
F1 = 4/pi/e^2*(1 - e^2)^(3/4)*sqrt((E/(1 - e^2) - K)*(K - E)); 
F1 = F1^(1/3); 
F2 = 2/pi*(1 - e^2)^(1/4)/F1*K; 
area = (xi_ - d_)/sqrt(kappa_1_*kappa_2_)*F1^2/F2*kappa_2_/x/z; 
area = Phi*area; 
% - Load
load = (xi_ - d_)^(3/2)/(kappa_1_*kappa_2_)^(1/4)*F2^(-3/2)*kappa_2_/x/z; 
load = Phi*load; 