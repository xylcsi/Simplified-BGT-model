function [BGT_area, BGT_load] = BGT_simplified(alpha, d_, N)

% Inputs: 
   Nx = N(1); 
   Ny = N(2); 
   Nz = N(3); 
%   
% Gauss quadrature abscissaes and weights (4 integral points)
xi = [-0.8611363115940526D0; -0.3399810435848563D0; 0.3399810435848563D0; 0.8611363115940526D0];
 w = [ 0.3478548451374538D0;  0.6521451548625461D0; 0.6521451548625461D0; 0.3478548451374538D0];
%
x = linspace(0, exp(-d_), Nx); 
y = linspace(0, 1, Ny); 
z = linspace(0, 1, Nz); 
BGT_area = 0;
BGT_load = 0;
%
for i = 1: Nx - 1
    for j = 1: Ny - 1
        for k = 1: Nz - 1
            % Integral over single cubic element
            x1 = x(i); x2 = x(i+1); 
            y1 = y(j); y2 = y(j+1); 
            z1 = z(k); z2 = z(k+1);
            for i_ = 1: 4
                for j_ = 1: 4
                    for k_ = 1: 4
                        xhd = (x2 - x1)/2; 
                        xhs = (x2 + x1)/2; 
                        yhd = (y2 - y1)/2; 
                        yhs = (y2 + y1)/2; 
                        zhd = (z2 - z1)/2; 
                        zhs = (z2 + z1)/2; 
                        [BGT_area0, BGT_load0] = BGT_sub(xhd*xi(i_) + xhs, yhd*xi(j_) + yhs, ...
                                                         zhd*xi(k_) + zhs, d_, alpha); 
                        BGT_area0 = (x2 - x1)*(y2 - y1)*(z2 - z1)/8*w(i_)*w(j_)*w(k_)*BGT_area0; 
                        BGT_load0 = (x2 - x1)*(y2 - y1)*(z2 - z1)/8*w(i_)*w(j_)*w(k_)*BGT_load0; 
                        BGT_area  = BGT_area + BGT_area0; 
                        BGT_load  = BGT_load + BGT_load0; 
                    end
                end
            end
        end
    end
end

BGT_area = sqrt(alpha)/6/sqrt(3)*BGT_area; 
BGT_load = 2*sqrt(2)/9/sqrt(3)/pi*alpha^(3/4)*BGT_load; 
