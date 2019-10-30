% script to that demonstrates structures
% and function calls
% charles stanier
% process control
% oct 2018

% using the Seider Tate heat transfer correlation
% as an example

close all
clear variables

Pe = 15; % Peclet number
L = 10; % meters
D = 0.1; % meters
vis_cor.docorrection = 1;  % set to one to do the viscosity correction
  % set to zero to skip the viscosity correction
vis_cor.bulkvisc = 100;
vis_cor.bulkvisc_units = 'cm (s g)-1';
vis_cor.wallvisc = 95;
vis_cor.wallvisc_units = 'cm (s g)-1';

Nu = SeiderTate( Pe, L, D, vis_cor )

% graph of Pe from 1 to 10000
Pe_vec = logspace( log10(1), log10(10000), 100);
for i=1:length(Pe_vec)
    Nu_vec(i) = SeiderTate( Pe_vec(i), L, D, vis_cor );
end
loglog(Pe_vec,Nu_vec,'k*-')
xlabel('Peclet Number');
ylabel('Nusselt Number');
% phone(1).owner = 'Charles Stanier';
% phone(1).model = 'iphone 8';
% phone(1).mass  = 67;
% phone(1).mass_units = 'grams';
% 
% phone(2).owner = 'Caleigh Stanier';
% phone(2).model = 'iphone 6';
% phone(2).mass  = 65;
% phone(2).mass_units = 'gram';
% 
% TM = phone_calc( phone )