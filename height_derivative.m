function dhdt = height_derivative( time, height, prob_info_struct )
% this function calculates the derivative of tank height
% based on dh/dt = 1/ rho*area * (qin - alpha*sqrt(h))

rho = prob_info_struct.rho;
if time >= prob_info_struct.flow_double_time
    qin = prob_info_struct.qin*2;
else
    qin = prob_info_struct.qin*1;
end
alpha = prob_info_struct.alpha;


dhdt = 1/ (rho*prob_info_struct.area) * (qin - alpha*sqrt(height));
% fprintf('Derivative evaluation at t = %f seconds; h = %f meters\n',time,height);
% fprintf('  Derivative at that point is: %f\n',dhdt);