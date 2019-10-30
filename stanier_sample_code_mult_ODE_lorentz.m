% sample MATLAB code for 052:185
% process dynamics and process control
% charles stanier, fall 2009
% University of Iowa

close all % closes any open graphics windows
clear variables % clears all variables from memory.  On the one hand, this prevents 

% solving the Lorentz system, which appears in atmospheric physics,
% chemical kinetics, and other systems.
% for some parameter values the solution is "attracted" to a stable fixed
% steady state.
% for other parameter values it is repulsed by a pair of points in 3D
% (x,y,z) space creating a complicated chaotic trajectory

% see http://en.wikipedia.org/wiki/Lorenz_system

% solving the system of differential equation 
%   dx/dt = sigma(y-x)
%   dy/dt = x(rho - z)
%   dz/dt = xy - beta z

% try varying rho from 10, 15, 20, and 25

problem_info.initial_condition_vec = [ 0 1 0  ]';
problem_info.sigma = 10;
problem_info.rho = 25;
problem_info.beta = 8/3;
problem_info.integration_time_span = [ 0 100 ];
problem_info.make_graph_flag = 1; % set to 1 or zero 
problem_info.semilogx_flag = 0; % set to 1 or 0

fprintf('Solving a user programmed differential equation\n');
fprintf('Some parameters are recorded in problem_info:\n');
problem_info
fprintf('Execution paused, any key to continue:\n');
pause

crit_rho = problem_info.sigma* (problem_info.sigma+problem_info.beta+3)/...
    (problem_info.sigma-problem_info.beta-1);
fprintf('The critical rho for an unstable solution is %f\n',crit_rho);
fprintf('Your rho is %f\n',problem_info.rho);

% we will use ode45 [T,Y] = solver(odefun,tspan,y0,options)
% if we wanted to set options, we would use odeset.
% here we will have default options except it will display
% some statistics 
options = odeset('Stats','on');
% things to try - RelTol of 1E-4 or 1E-5 instead of default
options = odeset('RelTol',1E-8);

% try ode15s as teh integrator instead of ode45
% see web([docroot '/techdoc/ref/ode45.html'])

% see notes on methods below (copied from matlab help page)

[ timeout outmatrix ] = ode45( @lorentz, ...
                             problem_info.integration_time_span, ...
                             problem_info.initial_condition_vec, ...
                             options, ...
                             problem_info);
                         
[ nrow ncol ] = size(outmatrix);
x = outmatrix(:,1);
y = outmatrix(:,2);
z = outmatrix(:,3);
fprintf('the output matrix from the solver is a %d by %d matrix\n',nrow,ncol);
                         
if problem_info.make_graph_flag == 1
    if problem_info.semilogx_flag 
        semilogx(timeout,x,'r-');
    else
        plot(timeout,x,'r-');
    end
    hold on;
    if problem_info.semilogx_flag
        semilogx(timeout,y,'b-');
        semilogx(timeout,z,'g-');
    else
        plot(timeout,y,'b-');
        plot(timeout,z,'g-');
    end
    legend('x','y','z');
    figure
    plot3(x,y,z);
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
