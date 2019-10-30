% sample MATLAB code for 052:185
% process dynamics and process control
% charles stanier, fall 2009
% University of Iowa

% objective.  
% this script is to Demonstrate some file input and output method

% it is a script, and all variables made or created are in the main
% workspace.  

% Name:     sample_code_5.m
% Purpose:  Demonstrate some file input and output methods
%
% some preliminary things that should go in almost all matlab scripts

close all % closes any open graphics windows
clear variables % clears all variables from memory.  On the one hand, this prevents 
 
fprintf('\n\n=======Running sample code 5==========\n');
 
%% A --- making up some fake data

ncustomers = 10;
for i=1:ncustomers
    customer(i).cust_number = i;
    customer(i).cust_address = 'not known';
    customer(i).purchases_last_10_months = rand(1)*10;
    customer(i)  %print it to screen
    pause(0.5); % pause 1/2 second
end

%% B --- easiest way to transfer data to/from files is as all numeric
%values - so put the numeric customer data in a matrix

for i=1:ncustomers
    customer_matrix(i,1) = customer(i).cust_number;
    customer_matrix(i,2) = customer(i).purchases_last_10_months;
end

total_purchases  = sum( customer_matrix(:,2));
fprintf('In fake data, total purchases were %f\n',total_purchases);

%% C --- save matrix to file

savepath = 'E:\CharFile_hp\temp2';

fname = 'customer_file.csv';

fullpath = [  savepath filesep fname ];


csvwrite(fname,customer_matrix);
%dlmwrite(fname,customer_matrix,'precision',8);

fprintf('saved date to file: %s.  Note: may have overwritten previous file of that name\n',fname);
fprintf('inspect the file using excel, wordpad, notepad, etc.\n');

fprintf('paused, any key to continue\n');
pause

%% D -- clear data out of memory, load from csv file
clear customer_matrix
clear customer
clear ncustomers

csvmatrix = csvread( fname );

[ ncustomers ncols ] = size(csvmatrix);
fprintf('Read in file %s and found %d rows and %d cols\n',fname,ncustomers,ncols);
for i=1:ncustomers
    customer(i).cust_number = csvmatrix(i,1);
    customer(i).purchases_last_10_months = csvmatrix(i,2);
    customer(i)  %print it to screen
    pause(0.5); % pause 1/2 second
end
total_purchases2 = sum( [ customer.purchases_last_10_months ] );
fprintf('In fake data, total purchases were %f\n',total_purchases);
fprintf('Reading from file, total purchases %f\n',total_purchases2);
fprintf('More precision can be achieved by using dlmwrite which contains a precision attribute\n');
fprintf('See commented out line of code with dlmwrite\n');

fprintf('-----------------------\n');
fprintf('there are ways of dealing with files that have text in them, but that is not necessary except\n');
fprintf('we may want to read in files with headers, as below\n');
fprintf('paused, any key to continue\n');
pause

fname = 'customer_file_with_headers.csv';
% this file has text headers, which will cause an error in csvread
csvmatrix = csvread(fname,1,0); % skips 1 row (the header row) and skips 0 columns
[ ncustomers ncols ] = size(csvmatrix);
fprintf('Read in file %s and found %d rows and %d cols\n\n',fname,ncustomers,ncols);

fprintf('xlsread is one way to deal with text (see below)\n');
fprintf('and to write a mix of text and numbers, fprintf is recommended but not covered here\n');
fprintf('paused, any key to continue\n');
pause
fname = 'customer_file_with_headers_and_text.csv';
% this file has a column of text, and xlsread does a better job than
% csvread
[numeric,txt,raw] = xlsread(fname); % skips 1 row (the header row) and skips 0 columns
% [ ncustomers ncols ] = size(csvmatrix);
% fprintf('Read in file %s and found %d rows and %d cols\n',fname,ncustomers,ncols);
fprintf('Read in file %s \n\n',fname);
fprintf('result from xlsread\n');
numeric
txt
raw



