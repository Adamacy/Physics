clear; clc; close all;

pret = [12.64, 14.32, 18.27, 23.76, 29.81, 36.85, 42.45] / 5;
pret = pret.^2
x = 0 : 0.05 : 0.30;
x = x.^2

p1 = polyfit(x, pret, 1);
slope1 = p1(1);
intercept1 = p1(2);

y_fit1 = polyval(p1, x);

y_mean1 = mean(pret);
SS_tot1 = sum((pret - y_mean1).^2);
SS_res1 = sum((pret - y_fit1).^2);
R_sq1 = 1 - (SS_res1 / SS_tot1);

% Plot the results (similar style to Python output)
figure('Position', [100, 100, 700, 500]); % Set figure size
scatter(x, pret, 70, 'filled', 'MarkerFaceColor', [0.12, 0.47, 0.71]); % 'C0' blue
hold on;
plot(x, y_fit1, 'r-', 'LineWidth', 2); % Use \newline for R^2 on new line
title('Linear Regression of Bar', 'FontSize', 14);
xlabel('r^2 [m^2]', 'FontSize', 12);
ylabel('T^2 [s^2]', 'FontSize', 12);
grid on;
hold off;
saveas(gcf, 'excersice_104_bar.png'); % Save the plot