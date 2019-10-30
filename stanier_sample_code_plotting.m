% sample MATLAB code for 052:185
% process dynamics and process control
% charles stanier, fall 2009
% University of Iowa

% objective.  
% this script is to demonstrate plotting of time series
% with several options
% the options to be explored are 1. labeling lines
% 2. logarithmic axes
% 3.  subplots
% 4.  yy axes

% also exporting of plots will be demonstrated

% it is a script, and all variables made or created are in the main
% workspace.  

% Name:     sample_code_4.m
% Purpose:  Demonstrate many plotting features
%
% some preliminary things that should go in almost all matlab scripts

close all % closes any open graphics windows
clear variables % clears all variables from memory.  On the one hand, this prevents 
 
fprintf('\n\n=======Running sample code 4==========\n');
 
%% A --- making up some sample data

numpoints = 150;
time_vec = linspace(0,100,numpoints);  % a vector of time values

period = 10;
amp = 5;
f1 = amp*sin(time_vec/period*2*pi);  % a sin wave with period and amplitude user selected
f2 = time_vec.^2;  % sqaring each element individually

% now scale f2 so that it is nowhere more than 5 times f1
% this is not necesary but helps put the graphs on the same plot
% and both be visible
scale_fac = max(abs(f2))/max(abs(f1));

f2 = f2/scale_fac;


%% B --- a simple plot

fig1 = figure; % opens a new figure window
plot(time_vec,f1); % plots x vs y
hold on; % whatever we do now will be on top of the existing plot figure contents
plot(time_vec,f2);
xlabel('Time');
ylabel('Function Value');
title('Example Plot B');
pause

%% C --- controlling line style and line color

% three ways to do this.  #1 in the plot command, #2 afterwards in a second
% #3 in a graphical user interface.  Here we show #2.

% help on this topic, type web([docroot '/techdoc/ref/line_props.html'])
% in the command line

fig2 = figure;
h2A = plot(time_vec,f1);  % h2A is a 'handle' to that feature in the plot
% view the properties of h2A using get
fprintf('\n\n----------- example C line & axes properties printout -------------\n\n');

proplist = get(h2A)

% lets change the Color, the LineStyle, the LineWidth, and the Marker

% color is a 3 element vector with [ Red Green Blue ] and each is 0-1. 
% for more explanation type web([docroot '/techdoc/ref/colorspec.html']) in
% command line

% let's do green, is [ 0 1 0 ] or 'g' as the help page explains
set(h2A,'Color','g');
pause

% now lets make the line style different, to a dotted line
set(h2A,'LineStyle',':');
pause

% now lets make the line thicker
set(h2A,'LineWidth',2);
pause

% and finally let's add markers
% list of symbols in web([docroot '/techdoc/ref/line_props.html'])
set(h2A,'Marker','x');
pause

%% D --- controlling axes type and subplotting

% three ways to make log axes.  1.  using semilog and loglog commands
% 2. changing the axes properties in the command window
% 3. changing the axes properties in the graphical figure editor

% we demonstrate 1 and 2 here

% since we are to compare several plots, we will use the subplot command
% (type helpwin subplot)

fig3 = figure;
subplot(2,2,1); % sets us the the first panel is a 2x2 tiled panel of plots
semilogx( time_vec,f2);

subplot(2,2,2); % sets us to the 2nd panel in a 2x2 tiled panel
semilogy( time_vec,f2);

pause

subplot(2,2,3);
loglog(time_vec,f2);

pause

% and from the command line
subplot(2,2,4);
plot(time_vec,f1);

pause

% gca is get current axes

AX = gca;

% look at the properties of AX
fprintf('\n\n----------- example D axes properties printout -------------\n\n');


axprop = get(AX)

% and change the XScale property to log
set(AX,'XScale','Log');

%% E - getting previous plot windows

% let's get our first plot and change the xscale.
% first set the current plot to figure 1

figure(fig1);
pause
set(gca,'XScale','Log'); % gca inserts the current axes handle
pause

% now close figure 1
close(fig1);

%% F -- multiple Y scales

% this is easy to do if you are not too interested in customizing the lines
% and axes.  For a method that is more full featured see Dr. Stanier's
% single_panel_yy_plot function

% let's NOT rescale f2

f2 = f2*scale_fac;

% and plot it

fig4 = figure;
plot(time_vec,f1);
hold on
plot(time_vec,f2);

pause

% it is really hard to see f1 now
% try plotyy instead
fig5 = figure;

[AX,H1,H2] = plotyy(time_vec,f1,time_vec,f2);
pause

% now let's modify the lines and add labels
% let's make the sine way red  h(1) refers to f1 and h(2) refers to f2
set(H1,'Color',[1 0 0 ]);
pause

% that would work better if the lettering on the left axes was also red
% look at properties of left hand axes
fprintf('\n\n----------- example F AX(1) printout -------------\n\n');

get(AX(1))  % the property of interest is YColor
set(AX(1),'YColor','r');
% we can also change the limits
set(AX(1),'YLim',[-10 10])

pause

% now let's make the f2 line thicker
set(H2,'LineWidth',3);

% and now for titles and lables
title('YY Plot Example');
xlabel('Time');
ylabel(AX(1),'Function 1 value');
ylabel(AX(2),'Function 2 value');

pause

% now let's export the figure for use in a document.
% at least 3 ways to do this

% method 1.  print

 print(fig5,'-dpng','-r450','printed_fig_ex.png');  % prints figure 5 as a 450 dot per inch png file
 
% method 2.  copy and paste.  In the figure window, go to 
% edit / Copy Figure    if you want, you can go to Edit / Copy Options
% first

% method 3.  Go to file / export setup.  Use the graphical user interface
% to get the figure the way you want it, then select "apply to figure" and then "export"
% when you get the chance to say where to save the file, select the "Save
% as" pull down and use the format of your choice.  We have good luck with
% JPEG, TIFF, and PNG formats


