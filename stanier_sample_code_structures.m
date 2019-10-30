% sample MATLAB code for 052:185
% process dynamics and process control
% charles stanier, fall 2009
% University of Iowa

% objective.  
% this script is to demonstrate structures
% and also debugging tools

% it is a script, and all variables made or created are in the main
% workspace.  
%
% some preliminary things that should go in almost all matlab scripts

% when you run this you will get an error.  After you fix that error it
% will run but not make sense.  
% use the debugging tools to execute line by line and figure out your
% errors
% see lecture demo of this

close all % closes any open graphics windows
clear variables % clears all variables from memory.  On the one hand, this prevents 
 
%% INTRO
% in this example we are going to find the zeros of some polynomials and make
% nice plots showing the results
%
% the polynomials that we want to solve will be stored in a structure
% structures very flexible ways to store data

% our structure will be like this

% polystruct(i).field1 = val
% polystruct(i).field2 = val

% where i is the polynomial we are referring to
% and field1, field2 are attributes that we care out

fprintf('\n\n============== starting sample code 3========\n\n');

%% A --- making up some sample data

% our first polynomial will be 3x^2 + 2x - 100 
% we will plot it in red
% and we will only be interested in the range 0-10

polystruct(1).coef_vec = [ 3 2 -100 ];  
polystruct(1).plot_color_string = 'r';
polystruct(1).x_range = [ -10 10 ];  
polystruct(1).name = 'function 1';

% our second polynomial will be -5x^3 + x 

polystruct(2).coef_vec = [ -5 0 1 0  ];  
polystruct(2).plot_color_string = 'k'; % black
polystruct(2).x_range = [ -10 10 ];  
polystruct(2).name = 'function 2';

num_poly = length(polystruct);
fprintf('Detected %d polynomials.  Solving one by one in for loop\n',num_poly);

fig1=figure;
AX_handle = gca;
hold on

minx = Inf;
maxx = -Inf;
for i=1:num_poly
    fprintf('Solving and plotting polynomial #%d\n',i)
    polystruct(i)
    
    % keeping track of minimum x and max x needed for plot axes
    minx = min(minx,polystruct(i).x_range(1));
    maxx = max(maxx,polystruct(i).x_range(2));
    
    % solve for the zeros and plot the polynomial in its appointed color
    polyzeroplotter( polystruct(i), AX_handle );
end
xlim( [ minx maxx ]);
    
