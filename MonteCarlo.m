%蒙特卡洛方法模拟蒲丰投针，计算圆周率，计算误差，画出误差曲线
% 蒲丰投针实验参数
L = 3; % 针的长度
d = 4; % 平行线的间距
N = 1000000; % 投针的总次数，修改为 100 万次

% 初始化相交次数
X = 0;

% 预分配空间
pi_estimates = zeros(floor(N/100),1);
trial_numbers = zeros(floor(N/100),1);
errors = zeros(floor(N/100),1);
theoretical_errors = zeros(floor(N/100),1);

% 随机投针实验
for i = 1:N
    % 随机生成针的中心位置和与水平线的夹角
    x_center = (d / 2) * rand; % 针中心到最近线的距离
    theta = pi * rand; % 针与平行线的夹角（随机在[0, pi)之间）

    % 判断是否相交
    if x_center <= (L / 2) * sin(theta)
        X = X + 1; % 如果相交，相交次数加一
    end

    % 每隔 100 次计算一次π的估计值和误差
    if mod(i, 100) == 0
        % 计算 π 的估计值
        pi_estimate = (2 * L * i) / (d * X);
        pi_estimates(floor(i/100)) = pi_estimate;
        trial_numbers(floor(i/100)) = i;

        % 计算误差
        error_value = pi_estimate - pi;
        errors(floor(i/100)) = error_value;

        % 计算理论误差
        p = (2 * L) / (pi * d);
        theoretical_error = 2 * pi * sqrt((1 - p) / (i * p));
        theoretical_errors(floor(i/100)) = theoretical_error;
    end
end

% 计算最终完成所有投针后π的估计值
final_pi_estimate = (2 * L * N) / (d * X);

% 显示最终结果
disp(['通过蒲丰投针实验估算的最终π值为：', num2str(final_pi_estimate)]);
disp(['最终π值与真实π值的相对误差为：', num2str(abs(final_pi_estimate - pi)/pi * 100), '%']);

% 可视化
figure;
plot(trial_numbers, errors, '-b');
hold on;
plot(trial_numbers, theoretical_errors, '-r');
plot(trial_numbers, -theoretical_errors, '-g');
plot(trial_numbers, zeros(size(trial_numbers)), '--k');
legend('估算的π值与真实π值的误差', '正理论误差', '负理论误差', '零误差线');
xlabel('投针次数');
ylabel('误差');
title('蒲丰投针实验中π值估算的误差变化曲线');
grid on;

% 设置横纵坐标范围
xlim([0, N]); % 设置 x 轴范围为 0 到 N
ylim([-0.1, 0.1]); % 设置 y 轴范围为 -0.1 到 0.1，可根据实际情况调整