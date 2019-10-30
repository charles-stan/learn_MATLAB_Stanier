% sample MATLAB code for 052:185
% process dynamics and process control
% charles stanier, fall 2009
% University of Iowa

% objective.  this program is designed to be a first program that students
% see in matlab.  

% it is a script, and all variables made or created are in the main
% workspace.  

% Name:     sample_code_1.m
% Purpose:  Say "Hello World!" in two different ways
%
% some preliminary things that should go in almost all matlab scripts
close all % closes any open graphics windows
clear variables % clears all variables from memory.  On the one hand, this prevents 
 % some errors where arrays used in previous runs are still in memory and
 % (if they are not properly initialized) those previous values can cause
 % problems.  On the other hand, sometimes we write scripts designed to
 % operate on variables that are already in memory and we would not want to
 % do clear variables in that case
 
 number_entry_method = 2; % 1 for old fashioned hard code.
 % 2 for graphical user window
 
%% part one - Hello World
% Do it the good ol' fashioned way...command window
disp('Hello World!');

% Do it the new hip GUI way...with a message box
msgbox('Hello World!','Hello World!');

disp('Press any key to continue');
pause

%% part two show what a function is.  
% we will write our own function that takes a number and 
% calculates the nth power of it, and also splits it at the decimal point

% here is a fancy way to get two numbers entered into memory

if number_entry_method == 2

    prompt={'Enter a number to operate on:','Enter the exponent to use:'};
    name='Input for Peaks function';
    numlines=1;
    defaultanswer={'NaN','NaN'};

    answer=inputdlg(prompt,name,numlines,defaultanswer);

    % now convert answer to numeric values
    % this somewhat involved conversion has to do with the fact
    % that answer is a cell array (size 2x1) of strings.  
    n = str2num(char(answer(1)));
    e = str2num(char(answer(2)));
elseif number_entry_method == 1

% and here is a simple way to get two numbers into memory

% could just enter the values in the script directly
    n= 3;
    e= 2.3;
% or use the input command R = input('How many apples')
else
    error('number_entry_method variable not recognized');
end

[ val1 val2 val3 ] = custom_power_function( n, e);

fprintf('-------------\nResults\n');
fprintf('Calculation went as follows:\n');
fprintf('%f raised to the %f power gives %f\n',n,e,val1);
fprintf('This can be broken into %4.0f plus the fraction (to 4 decimal places) %6.4f\n',val2,val3);


