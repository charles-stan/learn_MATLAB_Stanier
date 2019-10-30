function dvecdt = lorentz( time, vec, prob_info_struct )
% this function calculates the lorentz attractor

x = vec(1);
y = vec(2);
z = vec(3);

dxdt = prob_info_struct.sigma * ( y - x);
dydt = x*(prob_info_struct.rho - z) - y;
dzdt = x*y - prob_info_struct.beta*z;

dvecdt = [ dxdt dydt dzdt ]';