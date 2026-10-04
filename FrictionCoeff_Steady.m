function [mu_steady,mu_x_steady,mu_y_steady] = FrictionCoeff_Steady(Fz,lambda_x,lambda_y) 
% Chapter 2.1 - Steady-state tire model
 
% Steady-state tire-road friction
 
% Tire parameters -------
% Reference values of wheel loads
Fz_1 = 4000;                % [N]   Lower reference value for wheel load
Fz_2 = 8000;                % [N]   Upper reference value for wheel load
 
%---- Longitudinal
lambdaM_x_1 = 0.12;         % [-]   Longitudinal slip at maximum friction
lambdaM_x_2 = 0.10;         % [-]   Longitudinal slip at maximum friction
muM_x_1 = 1.1;              % [-]   Maximum friction coefficient in longitudinal direction
muM_x_2 = 1.0;              % [-]   Maximum friction coefficient in longitudinal direction
lambdaG_x_1 = 0.7;          % [-]   Longitudinal slip at transition to complete sliding
lambdaG_x_2 = 0.8;          % [-]   Longitudinal slip at transition to complete sliding
muG_x_1 = 0.6;              % [-]   Sliding friction coefficient in longitudinal direction
muG_x_2 = 0.6;              % [-]   Sliding friction coefficient in longitudinal direction
dF0_x_1 = 120000;           % [N]   Tire longitudinal stiffness (tread)
dF0_x_2 = 200000;           % [N]   Tire longitudinal stiffness (tread)
 
%---- Lateral
lambdaM_y_1 = 0.11;         % [-]   Lateral slip at maximum friction
lambdaM_y_2 = 0.09;         % [-]   Lateral slip at maximum friction
muM_y_1 = 0.8;              % [-]   Maximum friction coefficient in lateral direction
muM_y_2 = 0.7;              % [-]   Maximum friction coefficient in lateral direction
lambdaG_y_1 = 0.5;          % [-]   Lateral slip at transition to complete sliding
lambdaG_y_2 = 0.6;          % [-]   Lateral slip at transition to complete sliding
muG_y_1 = 0.6;              % [-]   Sliding friction coefficient in lateral direction
muG_y_2 = 0.6;              % [-]   Sliding friction coefficient in lateral direction
dF0_y_1 = 100000;           % [N]   Tire lateral stiffness (tread)
dF0_y_2 = 150000;           % [N]   Tire lateral stiffness (tread)
 
% Combined slip (lambda)
lambda = sqrt(lambda_x^2+lambda_y^2); 
 
if Fz > 0
    % ----- Pure longitudinal slip -----------------------------------------------------------
    % Accounting for wheel-load dependence of the maximum tire force
    % Quadratic interpolation
    dF0_x = Fz/(Fz_1-Fz_2)*((Fz-Fz_2)/Fz_1*dF0_x_1 - (Fz-Fz_1)/Fz_2*dF0_x_2); 
    
    % Linear interpolation
    muM_x =  1/(Fz_1-Fz_2)*((Fz-Fz_2)*muM_x_1 - (Fz-Fz_1)*muM_x_2); 
    muG_x =  1/(Fz_1-Fz_2)*((Fz-Fz_2)*muG_x_1 - (Fz-Fz_1)*muG_x_2); 
    lambdaM_x = 1/(Fz_1-Fz_2)*((Fz-Fz_2)*lambdaM_x_1 - (Fz-Fz_1)*lambdaM_x_2); 
    lambdaG_x = 1/(Fz_1-Fz_2)*((Fz-Fz_2)*lambdaG_x_1 - (Fz-Fz_1)*lambdaG_x_2); 
    
    % Curve parameters:
    a_x = muM_x^2*Fz/(dF0_x*lambdaM_x^3); 
    lambdaWP_x = min(lambdaM_x + (muM_x - muG_x)/(a_x*(lambdaG_x - lambdaM_x)),lambdaG_x); 
    b_x = a_x*(lambdaWP_x-lambdaM_x)/(lambdaG_x-lambdaWP_x); 
    
    % Case distinction
    if lambda <= lambdaM_x
        % 1st section
        D_x = 1 + (lambda/lambdaM_x)*(lambda/lambdaM_x + dF0_x/Fz/muM_x*lambdaM_x - 2); 
        mu_x0_steady = (dF0_x/Fz)*(lambda/D_x); 
    elseif lambda < lambdaWP_x
        % 2nd section
        mu_x0_steady = muM_x - a_x*(lambda - lambdaM_x)^2; 
    elseif lambda < lambdaG_x
        % 3rd section
        mu_x0_steady = muG_x + b_x*(lambdaG_x - lambda)^2; 
    else % lambda >= lambdaG_x
        % Complete sliding
        mu_x0_steady = muG_x; 
    end 
    
    % ----- Pure lateral slip -----------------------------------------------------------
    % Accounting for wheel-load dependence of the maximum tire force
    % Quadratic interpolation
    dF0_y = Fz/(Fz_1-Fz_2)*((Fz-Fz_2)/Fz_1*dF0_y_1 - (Fz-Fz_1)/Fz_2*dF0_y_2); 
    
    % Linear interpolation
    muM_y =  1/(Fz_1-Fz_2)*((Fz-Fz_2)*muM_y_1 - (Fz-Fz_1)*muM_y_2); 
    muG_y =  1/(Fz_1-Fz_2)*((Fz-Fz_2)*muG_y_1 - (Fz-Fz_1)*muG_y_2); 
    lambdaM_y = 1/(Fz_1-Fz_2)*((Fz-Fz_2)*lambdaM_y_1 - (Fz-Fz_1)*lambdaM_y_2); 
    lambdaG_y = 1/(Fz_1-Fz_2)*((Fz-Fz_2)*lambdaG_y_1 - (Fz-Fz_1)*lambdaG_y_2); 
    
    % Curve parameters:
    a_y = muM_y^2*Fz/(dF0_y*lambdaM_y^3); 
    lambdaWP_y = min(lambdaM_y + (muM_y - muG_y)/(a_y*(lambdaG_y - lambdaM_y)),lambdaG_y); 
    b_y = a_y*(lambdaWP_y-lambdaM_y)/(lambdaG_y-lambdaWP_y); 
    
    % Case distinction
    if lambda <= lambdaM_y
        % 1st section
        D_y = 1 + (lambda/lambdaM_y)*(lambda/lambdaM_y + dF0_y/Fz/muM_y*lambdaM_y - 2); 
        mu_y0_steady = (dF0_y/Fz)*(lambda/D_y); 
    elseif lambda < lambdaWP_y
        % 2nd section
        mu_y0_steady = muM_y - a_y*(lambda - lambdaM_y)^2; 
    elseif lambda < lambdaG_y
        % 3rd section
        mu_y0_steady = muG_y + b_y*(lambdaG_y - lambda)^2; 
    else % lambda >= lambdaG_y
        % Complete sliding
        mu_y0_steady = muG_y; 
    end 
    
    % ----- Combined slip: -----------------------------------------------------------
    % Direction of action (epsilon)
    if lambda ~= 0 
        cos_eps = lambda_x/lambda; 
        sin_eps = lambda_y/lambda; 
    else 
        cos_eps = 0; 
        sin_eps = 0; 
    end 
    
    % Friction coefficient
    if lambda > 0 
        mu_steady   = sqrt((mu_x0_steady*cos_eps)^2+(mu_y0_steady*sin_eps)^2); 
        mu_x_steady = mu_steady*cos_eps; 
        mu_y_steady = mu_steady*sin_eps; 
    else 
        mu_x_steady = 0.0; 
        mu_y_steady = 0.0; 
        mu_steady   = 0.0; 
    end 
 
else 
    mu_x_steady = 0.0; 
    mu_y_steady = 0.0; 
    mu_steady   = 0.0; 
end
