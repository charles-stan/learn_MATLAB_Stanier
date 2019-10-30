% sample MATLAB code for 052:185
% process dynamics and process control
% charles stanier, fall 2009
% University of Iowa



% Name:     sample_code_6.m
% Purpose:  Demonstrate solving of differential equations using Runge-Kutta
% methods
%
% some preliminary things that should go in almost all matlab scripts

close all % closes any open graphics windows
clear variables % clears all variables from memory.  On the one hand, this prevents 

% solving the differential dh/dt = 1/(A*rho) * [ Qin - alpha * sqrt(h) ] 
% A is 1 meter squared
% fluid is water
% alpha flow coefficient

problem_info.initial_condition = 0;  % meters    initial height - user set
problem_info.qin = 5; % kg/sec
problem_info.integration_time_span = [ 0 1E6 ];
problem_info.alpha = 0.5; % meters^2.5 / s
problem_info.make_graph_flag = 1; % set to 1 or zero 
problem_info.area = 1; % meters squared
problem_info.rho = 1000; % kg/m3
problem_info.flow_double_time = 3E5; % double qin at this time (sec)

fprintf('Solving a user programmed differential equation\n');
fprintf('Some parameters are recorded in problem_info:\n');
problem_info
fprintf('Matlab script paused, any key to continue:\n');
pause

fprintf('Analytical steady state solution from Qin = alpha * sqrt(h)\n');

h_ss = (problem_info.qin / problem_info.alpha)^2;
fprintf('Steady state solution should be %f meters.\n  Check numerical solution to see if this is true\n',h_ss);
pause
% we will use ode45 [T,Y] = solver(odefun,tspan,y0,options)
% if we wanted to set options, we would use odeset.
% here we will have default options except it will display
% some statistics 
options = odeset('Stats','on');
%options = odeset('MaxStep',5);
% things to try - RelTol of 1E-4 or 1E-5 instead of default
options = odeset('RelTol',1E-4);

% try ode15s as teh integrator instead of ode45
% see web([docroot '/techdoc/ref/ode45.html'])

% see notes on methods below (copied from matlab help page)

[ timeout heightout ] = ode45( @height_derivative, ...
                             problem_info.integration_time_span, ...
                             problem_info.initial_condition, ...
                             options, problem_info);
                         
if problem_info.make_graph_flag == 1
    plot(timeout, heightout,'bx-');
    xlabel('time (sec)');
    ylabel('height (m)');
    % ylim([0 12]);
end

% ode45 is based on an explicit Runge-Kutta (4,5) formula, the
% Dormand-Prince pair. It is a one-step solver – in computing y(tn), it
% needs only the solution at the immediately preceding time point, y(tn-1).
% In general, ode45 is the best function to apply as a first try for most
% problems. [3]
% 
% ode23 is an implementation of an explicit Runge-Kutta (2,3) pair of
% Bogacki and Shampine. It may be more efficient than ode45 at crude
% tolerances and in the presence of moderate stiffness. Like ode45, ode23
% is a one-step solver. [2] 
% 
% ode113 is a variable order Adams-Bashforth-Moulton PECE solver. It may be
% more efficient than ode45 at stringent tolerances and when the ODE file
% function is particularly expensive to evaluate. ode113 is a multistep
% solver — it normally needs the solutions at several preceding time points
% to compute the current solution. [7]
% 
% The above algorithms are intended to solve nonstiff systems. If they
% appear to be unduly slow, try using one of the stiff solvers below.
% 
% ode15s is a variable order solver based on the numerical differentiation
% formulas (NDFs). Optionally, it uses the backward differentiation
% formulas (BDFs, also known as Gear's method) that are usually less
% efficient. Like ode113, ode15s is a multistep solver. Try ode15s when
% ode45 fails, or is very inefficient, and you suspect that the problem is
% stiff, or when solving a differential-algebraic problem. [9], [10]
% 
% ode23s is based on a modified Rosenbrock formula of order 2. Because it
% is a one-step solver, it may be more efficient than ode15s at crude
% tolerances. It can solve some kinds of stiff problems for which ode15s is
% not effective. [9]
% 
% ode23t is an implementation of the trapezoidal rule using a "free"
% interpolant. Use this solver if the problem is only moderately stiff and
% you need a solution without numerical damping. ode23t can solve DAEs.
% [10]
% 
% ode23tb is an implementation of TR-BDF2, an implicit Runge-Kutta formula
% with a first stage that is a trapezoidal rule step and a second stage
% that is a backward differentiation formula of order two. By construction,
% the same iteration matrix is used in evaluating both stages. Like ode23s,
% this solver may be more efficient than ode15s at crude tolerances. [8],
% [1]
