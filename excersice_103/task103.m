clearvars;
close all;
clc;

T_copper = [19.3, 24.9, 29.9, 34.8, 40.4, 44.8, 49.7, 54.8];
dL_copper = [0.00, 0.07, 0.14, 0.20, 0.30, 0.34, 0.41, 0.47];
T_brass = [19.2, 25.0, 29.9, 34.8, 39.8, 44.8, 49.8, 54.9];
dL_brass = [0.00, 0.05, 0.16, 0.23, 0.32, 0.38, 0.45, 0.53];
T_steel = [19.6, 25.0, 29.9, 34.8, 39.9, 45.0, 49.8, 54.8];
dL_steel = [0.00, 0.05, 0.09, 0.14, 0.18, 0.23, 0.28, 0.32];

coef_copper = polyfit(T_copper, dL_copper, 1);
dL_fit_copper = polyval(coef_copper, T_copper);
fprintf('Copper fit: dL = %.4f * T + %.4f\n', coef_copper(1), coef_copper(2));

coef_brass = polyfit(T_brass, dL_brass, 1);
dL_fit_brass = polyval(coef_brass, T_brass);
fprintf('Brass fit: dL = %.4f * T + %.4f\n', coef_brass(1), coef_brass(2));

coef_steel = polyfit(T_steel, dL_steel, 1);
dL_fit_steel = polyval(coef_steel, T_steel);
fprintf('Steel fit: dL = %.4f * T + %.4f\n', coef_steel(1), coef_steel(2));


figure;
hold on; 

plot(T_copper, dL_copper, 'go', 'DisplayName', 'Copper Data');
plot(T_copper, dL_fit_copper, 'g-', 'LineWidth', 1.5, 'DisplayName', 'Copper Fit');

plot(T_brass, dL_brass, 'ro', 'DisplayName', 'Brass Data');
plot(T_brass, dL_fit_brass, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Brass Fit');

plot(T_steel, dL_steel, 'bo', 'DisplayName', 'Steel Data');
plot(T_steel, dL_fit_steel, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Steel Fit');
xlabel("t [°C]");
ylabel("\DeltaL [cm]");
title("Thermal Expansion of Metals: Data and Linear Regression");
legend('show', 'Location', 'northwest');
grid on;
hold off;