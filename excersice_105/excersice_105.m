m_g = [50; 100; 150; 200; 250; 300; 350; 400; 450; 500];

copper_1_mm = [0.56; 1.05; 1.63; 2.19; 2.74; 3.32; 3.83; 4.46; 5.00; 5.57];
copper_2_mm = [0.62; 1.18; 1.76; 2.33; 2.83; 3.41; 4.00; 4.61; 5.15; 5.74];
copper_3_mm = [0.48; 0.91; 1.33; 1.75; 2.18; 2.62; 3.04; 3.46; 3.91; 4.34];

aluminium_1_mm = [0.57; 1.14; 1.65; 2.21; 2.77; 3.30; 3.87; 4.43; 5.00; 5.54];
aluminium_2_mm = [0.77; 1.42; 2.07; 2.73; 3.31; 4.02; 4.64; 5.29; 5.96; 6.63];

brass_1_mm = [0.57; 1.07; 1.58; 2.08; 2.59; 3.10; 3.62; 4.13; 4.64; 5.15];
brass_2_mm = [0.78; 1.50; 2.19; 2.97; 3.68; 4.40; 5.16; 5.83; 6.61; 7.28];

g = 9.81;
m_kg = m_g / 1000;
F_g = m_kg * g;

p_c1 = polyfit(F_g, copper_1_mm, 1);
a_c1 = p_c1(1);
y_c1_fit = polyval(p_c1, F_g);
str_c1 = sprintf('I_C: y = %.4fx + %.4f', a_c1, p_c1(2));

p_c2 = polyfit(F_g, copper_2_mm, 1);
a_c2 = p_c2(1);
y_c2_fit = polyval(p_c2, F_g);
str_c2 = sprintf('II_C: y = %.4fx + %.4f', a_c2, p_c2(2));

p_c3 = polyfit(F_g, copper_3_mm, 1);
a_c3 = p_c3(1);
y_c3_fit = polyval(p_c3, F_g);
str_c3 = sprintf('III_C: y = %.4fx + %.4f', a_c3, p_c3(2));

figure;
hold on;
plot(F_g, copper_1_mm, 'ro', 'MarkerFaceColor', 'r');
plot(F_g, y_c1_fit, 'r-');

plot(F_g, copper_2_mm, 'go', 'MarkerFaceColor', 'g');
plot(F_g, y_c2_fit, 'g-');

plot(F_g, copper_3_mm, 'bo', 'MarkerFaceColor', 'b');
plot(F_g, y_c3_fit, 'b-');

title('Copper Deflection vs. Force');
xlabel('Force (N)');
ylabel('Deflection (mm)');
legend(str_c1, '', str_c2, '', str_c3, '', 'Location', 'northwest');
grid on;
hold off;
saveas(gcf, 'excersice_105_copper.png');

p_a1 = polyfit(F_g, aluminium_1_mm, 1);
a_a1 = p_a1(1);
y_a1_fit = polyval(p_a1, F_g);
str_a1 = sprintf('IV_A: y = %.4fx + %.4f', a_a1, p_a1(2));

p_a2 = polyfit(F_g, aluminium_2_mm, 1);
a_a2 = p_a2(1);
y_a2_fit = polyval(p_a2, F_g);
str_a2 = sprintf('V_A: y = %.4fx + %.4f', a_a2, p_a2(2));

figure;
hold on;
plot(F_g, aluminium_1_mm, 'ro', 'MarkerFaceColor', 'r');
plot(F_g, y_a1_fit, 'r-');

plot(F_g, aluminium_2_mm, 'bo', 'MarkerFaceColor', 'b');
plot(F_g, y_a2_fit, 'b-');

title('Aluminium Deflection vs. Force');
xlabel('Force (N)');
ylabel('Deflection (mm)');
legend(str_a1, '', str_a2, '', 'Location', 'northwest');
grid on;
hold off;
saveas(gcf, 'excersice_105_aluminium.png');

p_b1 = polyfit(F_g, brass_1_mm, 1);
a_b1 = p_b1(1);
y_b1_fit = polyval(p_b1, F_g);
str_b1 = sprintf('VI_B: y = %.4fx + %.4f', a_b1, p_b1(2));

p_b2 = polyfit(F_g, brass_2_mm, 1);
a_b2 = p_b2(1);
y_b2_fit = polyval(p_b2, F_g);
str_b2 = sprintf('VII_B: y = %.4fx + %.4f', a_b2, p_b2(2));

figure;
hold on;
plot(F_g, brass_1_mm, 'ro', 'MarkerFaceColor', 'r');
plot(F_g, y_b1_fit, 'r-');

plot(F_g, brass_2_mm, 'bo', 'MarkerFaceColor', 'b');
plot(F_g, y_b2_fit, 'b-');

title('Brass Deflection vs. Force');
xlabel('Force (N)');
ylabel('Deflection (mm)');
legend(str_b1, '', str_b2, '', 'Location', 'northwest');
grid on;
hold off;
saveas(gcf, 'excersice_105_brass.png');

disp('Slope Coefficients (a_reg):');
fprintf('a_c1 (I_C):   %.4f\n', a_c1);
fprintf('a_c2 (II_C):  %.4f\n', a_c2);
fprintf('a_c3 (III_C): %.4f\n', a_c3);
fprintf('a_a1 (IV_A):  %.4f\n', a_a1);
fprintf('a_a2 (V_A):   %.4f\n', a_a2);
fprintf('a_b1 (VI_B): %.4f\n', a_b1);
fprintf('a_b2 (VII_B): %.4f\n', a_b2);

disp('----------------------------------');
disp('Calculating Young''s Modulus (E):');

l = 0.602;

b_width = [
    0.015;  % I_C
    0.015;  % II_C
    0.020;  % III_C
    0.010;  % IV_A
    0.021;  % V_A
    0.020;  % VI_B
    0.015   % VII_B
];

h_thick = [
    0.0003; % I_C
    0.0003; % II_C
    0.0003; % III_C
    0.0004; % IV_A
    0.0003; % V_A
    0.0003; % VI_B
    0.0003  % VII_B
];

a_reg_vec = [a_c1; a_c2; a_c3; a_a1; a_a2; a_b1; a_b2];

a_reg_m_N = a_reg_vec / 1000;

l_cubed = l^3;
h_cubed = h_thick.^3;

denominator = 4 .* a_reg_m_N .* b_width .* h_cubed;
E_Pa = l_cubed ./ denominator;

E_GPa = E_Pa / 1e9;

E_Copper_avg = mean(E_GPa(1:3));
E_Aluminium_avg = mean(E_GPa(4:5));
E_Brass_avg = mean(E_GPa(6:7));

% Create summary table
Bar = {'I_C'; 'II_C'; 'III_C'; 'IV_A'; 'V_A'; 'VI_B'; 'VII_B'};
E_GPa_Values = round(E_GPa, 2);
Average_E_GPa = [E_Copper_avg; E_Copper_avg; E_Copper_avg; E_Aluminium_avg; E_Aluminium_avg; E_Brass_avg; E_Brass_avg];
Average_E_GPa = round(Average_E_GPa, 2);

results_table = table(Bar, E_GPa_Values, Average_E_GPa);
results_table.Properties.VariableNames = {'Bar', 'E_GPa', 'Average_E_GPa'};

disp('Calculated Young''s Modulus (E):');
disp(results_table);

