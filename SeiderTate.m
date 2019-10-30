function Nu = SeiderTate( Pe, L, D, vs )
% this takes in Peclet number
% length , diameter
% viscosity structure with fields
%  .docorrection (1 to enable, 0 to disable)
%  .bulkvisc (viscosity along centerline)
%  .bulkvisc_units (string with units)
%  .wallvisc (viscosity at wall)
%  .wallvisc_units (string with units)

% Charles Stanier
% charles-stanier@uiowa.edu
% oct 2018
% source: Welty, Wicks, Wilson Rorrer
% Fundamentals of Momentum mass and heat transfer
% edition 5

Nu_no_correct = 1.86*(Pe*D/L)^(1/3);
% note D and L assumed to be in same units
% but no error checking for this

if vs.docorrection == 1
    % do viscosity correction,
    % viscosity at wall vs. bulk effects result
    mult=(vs.bulkvisc/vs.wallvisc)^0.14;
    % error check on units
    comp_flag = strcmp( vs.bulkvisc_units,vs.wallvisc_units);
    if comp_flag == 1
        % OK
    else
        % not ok
        disp('viscosity units do not match');
        Nu=NaN;
        return;
    end
    Nu = Nu_no_correct * mult;
else
    Nu = Nu_no_correct;
end