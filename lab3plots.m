%% GENG3402 Laboratory 3 MATLAB Plots
% Author: Allan Wu (23810308)
% Date/time: 30 September 2026

%% Pre-lab values
Kbb = 0.4183;
Kc = 3.1456;
z = 0.9413;

function plot_root_locus(Kbb, Kc, z)
    % Transfer function for BB01 (ideal PD control) is
    % Kbb Kc z / (s^2 + Kbb Kc s + Kbb Kc z)
    s = tf('s');
    T = Kbb*Kc*z / (s^2 + Kbb*Kc*s + Kbb*Kc*z);
    figure;
    rlocusplot(T);
    sgrid;
end

function plot_position_theta(x_matfile, theta_matfile)
    x = open(x_matfile);
    theta_l = open(theta_matfile);
    t = x.data_x(:, 1);
    setpoint = x.data_x(:, 2);
    ball_pos = x.data_x(:, 3);
    servo_angle = theta_l.data_theta_l(:, 2);

    figure;
    set(gcf, 'Color', 'white');
    tiledlayout(2,1,'TileSpacing','tight');
    nexttile;
    box on;
    hold on;
    title('Simulated ideal PD with no servo dynamics');
    xlabel('Time (seconds)');
    grid;
    plot(t, setpoint, 'Color', 'black', 'LineStyle', '-.', 'LineWidth', 0.75);
    plot(t, ball_pos, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 1);
    ylabel('Position (metres)');
    ylim([-8 8]);
    legend({'Setpoint Position', 'Simulated Ball Position'});
    nexttile;
    colororder({'k', 'r'}); % Override axes colors
    yyaxis left;
    plot(t, ball_pos, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 0.75);
    ylabel('Position (metres)');
    ylim([-8 8]);
    yyaxis right;
    plot(t, servo_angle, 'Color', 'red', 'LineWidth', 1);
    ylabel('Load angle (radians)');
    grid;
end


%% Begin main script
% Plot root locus for ideal PD controller
plot_root_locus(Kbb, Kc, z);

% Plot for section 4.1.1 step 9
plot_position_theta("data/data_x_simulation411.mat", ...
    "data/data_theta_l_simulation411.mat");