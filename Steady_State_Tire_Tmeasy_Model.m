% Chapter 2.1 - Steady-state tire model

% Wheel load

Fz = 5000; 

% Slip quantities -------

lambda_x = -0.5:0.02:0.5;

lambda_y = -0.5:0.02:0.5;

[LX,LY] = meshgrid(lambda_x,lambda_y); % Create a matrix for 3D plots

% Attention:

% meshgrid: columns -> x-values; rows -> y-values:

% Example:

%     [X,Y] = meshgrid(x,y);

%         Z = X.*Y;

%     Then: Z(m,n) == x(n)*y(m);

% However, in the functions mu, mu_x and mu_y,

% the x-values are arranged row-wise and the y-values column-wise

% => therefore transposition is necessary:

LX = LX.';

LY = LY.';

% Determination of the friction coefficients -------

%

for k1 = 1:length(lambda_x)

    for k2 = 1:length(lambda_y)

        [mu_TMP,mu_x_TMP,mu_y_TMP] = FrictionCoeff_Steady(Fz,lambda_x(k1),lambda_y(k2));

        mu(k1,k2) = mu_TMP;

        mu_x(k1,k2) = mu_x_TMP;

        mu_y(k1,k2) = mu_y_TMP;

    end

end

% Graphical representation -------

%

figure

surfc(LX,LY,mu)

xlabel('\lambda_x [-]')

ylabel('\lambda_y [-]')

zlabel('\mu(\lambda_x,\lambda_y) [-]')

title('Friction coefficient \mu [-]');

figure

surfc(LX,LY,mu_x)

xlabel('\lambda_x [-]')

ylabel('\lambda_y [-]')

zlabel('\mu_x(\lambda_x,\lambda_y) [-]')

title('Friction coefficient \mu_x [-]');

figure

surfc(LX,LY,mu_y)

xlabel('\lambda_x [-]')

ylabel('\lambda_y [-]')

zlabel('\mu_y(\lambda_x,\lambda_y) [-]')

title('Friction coefficient \mu_y [-]');

