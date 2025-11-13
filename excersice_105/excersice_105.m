% Skrypt do obliczania Modułu Younga (E)
% oraz jego całkowitej niepewności (Delta_E)

clc;    % Wyczyść okno poleceń
clear;  % Wyczyść zmienne
close all; % Zamknij wszystkie rysunki

% -------------------------------------------------------------------------
% SEKCJA 1: STAŁE I ZAŁOŻENIA DOTYCZĄCE BŁĘDÓW POMIAROWYCH
% -------------------------------------------------------------------------

% Długość między podporami [m]
l = 0.602; 

% ZAŁOŻENIA dotyczące niepewności instrumentalnych [m]
% !!! ZMIEŃ TE WARTOŚCI, jeśli znasz dokładne niepewności przyrządów !!!

% Niepewność pomiaru długości 'l' (np. linijka z podziałką 1mm)
delta_l = 0.001; % Założenie: +/- 1 mm

% Niepewność pomiaru szerokości 'b' (np. suwmiarka z noniuszem)
delta_b = 0.00005; % Założenie: +/- 0.05 mm

% Niepewność pomiaru wysokości 'h' (np. śruba mikrometryczna)
delta_h = 0.00001; % Założenie: +/- 0.01 mm

fprintf('Założone niepewności instrumentalne:\n');
fprintf('Delta_l = %.4f m (%.1f mm)\n', delta_l, delta_l*1000);
fprintf('Delta_b = %.5f m (%.2f mm)\n', delta_b, delta_b*1000);
fprintf('Delta_h = %.5f m (%.2f mm)\n\n', delta_h, delta_h*1000);


% -------------------------------------------------------------------------
% SEKCJA 2: DANE WEJŚCIOWE Z TABEL (BELKI 1-7)
% -------------------------------------------------------------------------

% Nazwy belek
bar_names = {'I_C', 'II_C', 'III_C', 'IV_A', 'V_A', 'VI_B', 'VII_B'};

% Wymiary belek [m] (z Tabeli 3)
b_vals = [0.015, 0.015, 0.020, 0.010, 0.021, 0.020, 0.015];
h_vals = [0.0003, 0.0003, 0.0003, 0.0004, 0.0003, 0.0003, 0.0003];

% Współczynniki regresji 'a_reg' [mm/N] (z Tabeli 2)
a_reg_mm_N = [1.1416, 1.1579, 0.8736, 1.1264, 1.3228, 1.0390, 1.4798];

% Błędy standardowe 'delta_a_reg' [mm/N] (z poprzedniego skryptu)
delta_a_reg_mm_N = [0.00607, 0.00615, 0.00198, 0.00364, 0.00525, 0.00148, 0.00550];

% KONWERSJA JEDNOSTEK do SI (metry i Newtony)
a_reg_m_N = a_reg_mm_N / 1000;         % [mm/N] -> [m/N]
delta_a_reg_m_N = delta_a_reg_mm_N / 1000; % [mm/N] -> [m/N]


% -------------------------------------------------------------------------
% SEKCJA 3: OBLICZENIA MODUŁU I BŁĘDU
% -------------------------------------------------------------------------

% Przygotowanie tabeli na wyniki
num_bars = length(bar_names);
E_vals_GPa = zeros(num_bars, 1);
delta_E_vals_GPa = zeros(num_bars, 1);

% Pętla przez wszystkie belki
for i = 1:num_bars
    
    % Pobranie danych dla bieżącej belki
    b = b_vals(i);
    h = h_vals(i);
    a_reg = a_reg_m_N(i);
    delta_a_reg = delta_a_reg_m_N(i);
    
    % --- Obliczenie Modułu Younga (E) ---
    % E = l^3 / (4 * a_reg * b * h^3)
    l_cubed = l^3;
    h_cubed = h^3;
    E = l_cubed / (4 * a_reg * b * h_cubed); % Wynik w Pascalach [Pa]
    
    
    % --- Obliczenie niepewności (błędu) ---
    % Wzór: (dE/E)^2 = (3*dl/l)^2 + (da_reg/a_reg)^2 + (db/b)^2 + (3*dh/h)^2
    
    % Składowe błędu względnego (do kwadratu)
    err_comp_l = (3 * delta_l / l)^2;
    err_comp_a = (delta_a_reg / a_reg)^2;
    err_comp_b = (delta_b / b)^2;
    err_comp_h = (3 * delta_h / h)^2;
    
    % Całkowity błąd względny do kwadratu
    total_rel_err_sq = err_comp_l + err_comp_a + err_comp_b + err_comp_h;
    
    % Całkowity błąd względny (dE/E)
    total_rel_err = sqrt(total_rel_err_sq);
    
    % Całkowity błąd bezwzględny (Delta_E)
    % delta_E = E * (dE/E)
    delta_E = E * total_rel_err; % Wynik w Pascalach [Pa]

    
    % Zapisanie wyników w GigaPascalach [GPa]
    E_vals_GPa(i) = E / 1e9;
    delta_E_vals_GPa(i) = delta_E / 1e9;
    
end


fprintf('Obliczone wartości Modułu Younga (E) wraz z niepewnością (Delta_E):\n');
fprintf('------------------------------------------------------------------------------\n');
fprintf('| Belka (Bar) | E [GPa]   | Delta_E [GPa] | Wynik (E ± Delta_E) [GPa]   |\n');
fprintf('|:------------|:----------|:--------------|:----------------------------|\n');

for i = 1:num_bars
    fprintf('| %-11s | %9.2f | %13.2f | (%6.2f ± %4.2f) GPa     |\n', ...
             bar_names{i}, E_vals_GPa(i), delta_E_vals_GPa(i), ...
             E_vals_GPa(i), delta_E_vals_GPa(i));
end
fprintf('------------------------------------------------------------------------------\n');