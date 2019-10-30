
% sample MATLAB code for 052:185
% process dynamics and process control
% charles stanier, fall 2009
% University of Iowa

% objective.  
% this script is to demonstrate a number of features of vectors and
% matrices
% and to provide sample code for students to solve their own problems
% using vectors and matrices

% it is a script, and all variables made or created are in the main
% workspace.  

% Name:     sample_code_2.m
% Purpose:  Demonstrate many matrix and vector features in matlab
%
% some preliminary things that should go in almost all matlab scripts
close all % closes any open graphics windows
clear variables % clears all variables from memory.  On the one hand, this prevents 
 
 
%% part one --- using helpwin

% you can always enter the help window by typing helpwin at the command
% line.
% for example, to go find a tutorial on vectors and matrices, I do the
% following

% 1.  type "helpwin"
% 2.  in the contents tab, expand the 'MATLAB' section
% 3.  in the MATLAB section, expand the 'Mathematics' section
%     in the Mathematics section, go to 'Matrices and Arrays / Creating and
%     Concatenating Matrices'
% PLEASE READ the first 4 sections (Creating and Concat, Matrix Indexing,
%   Getting Info.., and Resizing and Reshaping)

%% part two --- some examples

% A. making a vector explicitly

fprintf('\n-----------example A---------\n');

rowvec = [ 1 2 3 4 8 10 11 ];

% find out its size
[nrow ncol] = size(rowvec);
fprintf('The size of rowvec is %d x %d.\nIn other words it has %d rows and %d columns\n',nrow,ncol,nrow,ncol);

% now let's transpose it 

transrowvec = rowvec';
[nrow ncol] = size(transrowvec);
fprintf('The size of the transpose of rowvec is %d x %d.\nIn other words it has %d rows and %d columns\n',nrow,ncol,nrow,ncol);

% B.  making a vector out of random numbers
pause
fprintf('\n-----------example B---------\n');

Bvec = rand(10,1);  % makes a column vector of 10 random numbers

minB = min(Bvec);
maxB = max(Bvec);
fprintf('The smallest element in B is %f\n',minB);
fprintf('The largest element in B is %f\n',maxB);

% C.  making a vector using linear spacing
pause
fprintf('\n-----------example C---------\n');

Cvec = linspace( 10,1000, 10);  % makes a row vector that starts at 10, ends at 1000, and has 43 elements
disp(Cvec(1:5)); % displays the first 5 elements of Cvec
% note there is also a logspace

% D. making a vector by specifying the spacing
pause
fprintf('\n-----------example D---------\n');

startnum = 1.2;

Dvec = [ startnum:0.1:1.5 ]; % goes from startnum to 1.5 with a spacing of 0.1
disp(Dvec);

% E.  some simple vector operations
pause
fprintf('\n-----------example E---------\n');

% element by element operations.  
% lets say we wanted to 10 stock prices, and 10 stock values per share,
% and calculate the portfolio value

number_shares = floor(100*rand(1,10));
share_price   = 20*rand(1,10);

value_vector = number_shares .* share_price; % this will do element by element 
% multiplications

for i=1:length(number_shares);
    fprintf('  stock %i\t%d shares\t$%5.2f\t$%5.2f\n',i,number_shares(i),share_price(i),value_vector(i));
end
fprintf('total portfolio value: $%5.2f\n',sum(value_vector));

% F.  some more simple vector operations
pause
fprintf('\n-----------example F---------\n');

% dot products and cross products

vF1 = rand(1,4);
vF2 = rand(1,4);

% the size after matrix muliplication of ( a x b ) ( c x d ) = ( a x d ) AND b and c must match

% so we cannot multiply vF1 and vF2

%vF1 * vF2

% comment out the error

% but we can multiply   ( 1 x 4 ) ( 4 x 1 )  giving a 1 x 1 scalar.  
% that is the inner (or dot) product

dp = vF1 * vF2'

% and we can multiply  ( 4 x 1 ) ( 1 x 4 ) giving a 4 x 4 matrix

matF = vF1' * vF2

% and if we have a 1x3 array, that can represent a vector in 3D Euclidian
% space, and there the cross product is defined.  
% we no that the following is true

% parallel vectors, should have cross product of zero, and dot product of 1
% perpendicular vectors, should have cross product that is length 1 (and
% perpendicular to the original two vectors) and dot product of zero

v1 = [ 1 0 0 ]; % unit vector in x dir
v2 = [ 0 1 0 ]; % unit vector in y dir
v3 = [ 0 0 1 ]; % unit vector in z dir

% parallel vectors
fprintf('Dot product parallel\n');
v1*v1'
fprintf('Cross product parallel\n');
cross(v1,v1)
fprintf('Dot product perpendicular\n');
v1*v2'
fprintf('Cross product perpendicular\n');
cross(v1,v2)

pause
% G.  Ax=b type problems

fprintf('\n-----------example G---------\n');

% lets solve an Ax=b problem where A is a matrix, x is a vector, and b is a
% vector
% this is equivalant to solving a system of linear equations

% the system is overdetermined if there are many equations (long b, short
% x), fully specified (length x is length b, or more precisely the rank A
% is the length of b), or underdetermined (long x, short b).

% fully determined case

A = rand(4,4);
b = rand(4,1);

% then ( 4 x 4 ) ( 4 x 1 ) = ( 4 x 1)

x = A\b  % this is matrix 'left division'

% it is roughly equivalant to inv(A) b  but calculated differently
% run this from the command line to bring up the help
% web([docroot '/techdoc/ref/arithmeticoperators.html'])

% check your answer

fprintf('original b\n');
disp(b)
fprintf('Ax\n');
A*x
pause 

% can do this using the inverse feature, but if you don't need the inverse,
% you should avoid calculating it where possible

x2 = inv(A)*b

% now lets try an overdetermined case (long b, short x)
% or    ( 6 x 4 ) (4 x 1 ) = ( 6 x 1)
pause
fprintf('overdetermined case\n');
A = rand(6,4);
b = rand(6,1);

x = A\b 

fprintf('original b\n');
disp(b)
fprintf('Ax\n');
A*x
% in the overdetermined case, this solution is equivalent to a linear least
% squares best fit through the data

% now lets try an underdetermined case (long x, short b)
% or    ( 4 x 6 ) (6 x 1 ) = ( 4 x 1)
pause
fprintf('underdetermined case\n');
A = rand(4,6);
b = rand(4,1);

x = A\b 

fprintf('original b\n');
disp(b)
fprintf('Ax\n');
A*x
% in the overdetermined case, this solution is equivalent to a linear least
% squares best fit through the data
fprintf('matlab doesn''t tell you but this is not the only solution\n');
pause 

% example H, computational efficiency

pause
fprintf('\n-----------example H---------\n');

% lets time matlab and see how long it takes to calculate the eigenvalues
% of various random matrices

% let's go up to matrices of size 2 to the 10th (1024)

size = 2;
ncalcs = 10;
for exp=1:ncalcs
    fprintf('calculation %d of %d, please be patient\n',exp,ncalcs);
    nrow = 2^exp;
    M = rand( nrow );
    starttime = now;
    lambda = eig(M);
    endtime = now;
    elap_time_msec = (endtime-starttime)*24*60*60*1000; % converts the time from days to milli-seconds
    elap_time_vec(exp) = elap_time_msec;
    size_vec(exp) = nrow;
end

% make a log log plot
loglog(size_vec,elap_time_vec,'b-x');
xlabel('matrix size');
ylabel('computational time, msec');




