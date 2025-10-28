clearvars;
close all;
clc;

T_copper = [19.3, 24.9, 29.9, 34.8, 40.4, 44.8, 49.7, 54.8];
dL_copper = [0.00, 0.07, 0.14, 0.20, 0.30, 0.34, 0.41, 0.47];

T_brass = [19.2, 25.0, 29.9, 34.8, 39.8, 44.8, 49.8, 54.9];
dL_brass = [0.00, 0.05, 0.16, 0.23, 0.32, 0.38, 0.45, 0.53];

T_steel = [19.6, 25.0, 29.9, 34.8, 39.9, 45.0, 49.8, 54.8];
dL_steel = [0.00, 0.05, 0.09, 0.14, 0.18, 0.23, 0.28, 0.32];

figure;

plot(T_copper, dL_copper, '-g', 'LineWidth', 1.5, 'DisplayName', 'Copper');
hold on;

plot(T_brass, dL_brass, '-r', 'LineWidth', 1.5, 'DisplayName', 'Brass');

plot(T_steel, dL_steel, '-b', 'LineWidth', 1.5, 'DisplayName', 'Steel');

legend(['Copper'], [('Brass')], [('steel')]);
xlabel("t [°C]")
ylabel("ΔL [cm]")