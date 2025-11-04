% --- 1. Define Data ---
% This is the data we calculated in the previous step.
% d is in meters (m).
% I_exp and I_theor are in base units (kg*m^2).

d_m = [0.00, 0.02, 0.04, 0.06, 0.08, 0.10, 0.12, 0.14];
I_exp = [0.0056960, 0.0058014, 0.0060544, 0.0069836, 0.0078272, 0.0099829, 0.0109986, 0.0140039];
I_theor = [0.0055580, 0.0057324, 0.0062556, 0.0071276, 0.0083484, 0.0099180, 0.0118364, 0.0141036];

% Calculate the x-axis values (d^2)
d_squared = d_m.^2; % The .^ operator squares each element in the array

% --- 2. Create the Plot ---
figure;  % Create a new figure window
hold on; % Allow multiple plots on the same axes

% Plot 1: Experimental data (Blue dots)
% 'bo' creates blue (b) circles (o)
plot(d_squared, I_exp, 'bo', ...
     'MarkerFaceColor', 'b', ...      % Fills the circles with blue
     'MarkerSize', 6, ...             % Sets the marker size
     'DisplayName', 'Experimental I_{exp}'); % Name for the legend

% Plot 2: Theoretical data (Red line)
% 'r-' creates a red (r) solid line (-)
plot(d_squared, I_theor, 'r-', ...
     'LineWidth', 1.5, ...           % Makes the line slightly thicker
     'DisplayName', 'Theoretical I = I_0 + m_d d^2'); % Name for the legend

hold off; % Done plotting to these axes

% --- 3. Format the Chart ---
title("Verification of Steiner's theorem: I = f(d^2)");
xlabel('d^2 [m^2]');
ylabel('I [kg \cdot m^2]');

grid on; % Add grid lines, just like the example
box on;  % Add a box outline around the plot

% Add a legend and place it in the top-left corner
legend('show', 'Location', 'northwest');

% --- 4. Match Axis Scaling from Example ---
% This section forces the axes to use the "10^-2" notation

ax = gca; % Get the handle for the current axes

% Set the exponent for the x and y axes to -2
ax.XAxis.Exponent = -2;
ax.YAxis.Exponent = -2;

% Set the axis limits to match the style of the example
% (The example chart starts the x-axis slightly negative)
xlim([-0.002, 0.022]); % Corresponds to -0.2 to 2.2 on the scaled axis
ylim([0.005, 0.015]); % Corresponds to 0.5 to 1.5 on the scaled axis