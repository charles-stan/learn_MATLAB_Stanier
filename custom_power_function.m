function [ val1 val2 val3 ] = custom_power_function( n, e)
% this function is written to demonstrate an example of a matlab function
% matlab functions should be their own .m file and should have a file name 
% that matches the function name at the top of the function file

% function purpose:  calculate n^e and return the value, the value to the
% left of the decimal and the value to the right of the decimal

val1 = n^e;

val2 = fix(val1); % Round towards zero 
val3 = val1 - val2;