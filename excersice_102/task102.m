% Define the data
uklad1 = [18.748, 18.382, 18.195, 18.142, 18.220, 18.400, 18.651];
uklad2 = [18.891, 18.244, 17.691, 17.280, 17.213, 17.721, 19.396];
x = 32 : 10 : 92;

% Plot the two functions
plot(x, uklad1, '-o', 'DisplayName', 'Pivot 1');
hold on;
plot(x, uklad2, '-o', 'DisplayName', 'Pivot 2');

% Find intersection points
diff = uklad1 - uklad2;
sign_changes = find(diff(1:end-1) .* diff(2:end) < 0);

intersect_x = [];
intersect_y = [];

for i = 1:length(sign_changes)
    idx = sign_changes(i);
    
    % Linear interpolation
    x1 = x(idx);
    y1_1 = uklad1(idx);
    y1_2 = uklad2(idx);
    
    x2 = x(idx+1);
    y2_1 = uklad1(idx+1);
    y2_2 = uklad2(idx+1);
    
    m1 = (y2_1 - y1_1) / (x2 - x1);
    m2 = (y2_2 - y1_2) / (x2 - x1);
    
    c1 = y1_1 - m1 * x1;
    c2 = y1_2 - m2 * x1;
    
    xi = (c2 - c1) / (m1 - m2);
    yi = m1 * xi + c1;
    
    intersect_x = [intersect_x, xi];
    intersect_y = [intersect_y, yi];
end

% Plot the intersection points
if ~isempty(intersect_x)
    plot(intersect_x, intersect_y, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Intersection Points');
    for i = 1:length(intersect_x)
        text(intersect_x(i), intersect_y(i), sprintf('(%.3f, %.3f)', intersect_x(i), intersect_y(i)), 'VerticalAlignment', 'bottom');
    end
end

% Add labels and title
xlabel('L [cm]');
ylabel('T [s]');
legend('show');
grid on;
hold off;

% Display intersection points in the console
disp('Intersection points:');
for i = 1:length(intersect_x)
    fprintf('Intersection %d: (x = %.3f, y = %.3f)\n', i, intersect_x(i), intersect_y(i));
end