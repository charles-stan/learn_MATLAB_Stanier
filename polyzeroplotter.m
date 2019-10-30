function polyzeroplotter( polystruct, AX_handle )
% this function takes the figure defined by fighandle 
% and adds a plot of a polynomial and its zeros

% fields in teh input structure are
%              coef_vec: [-5 0 1 0]
%     plot_color_string: 'k'
%               x_range: [5 30]

% step 1 - graph the polynomial in the range of interest
% use matlab function polyval to evaluate the polynomial

points_per_unit = 100;

% determine number of x points to plot
npoints = (polystruct.x_range(1) - polystruct.x_range(1))*points_per_unit;
if npoints<10
    npoints=10;
end

xvec = linspace( polystruct.x_range(2), polystruct.x_range(1), npoints);
yvec = polyval( polystruct.coef_vec,  xvec );

h = plot(AX_handle, xvec, yvec );
set(h, 'Color', polystruct.plot_color_string);

% now add the label - use the y value at the midpoint of the range
index=floor(npoints/2);
xval = xvec(index);
yval = yvec(index);
th = text(xval,yval,polystruct.name);
set(th,'Color',polystruct.plot_color_string);

% now find the zeros 

r = roots(polystruct.coef_vec)

real_part = real(r);
imag_part = imag(r);

is_imag_binary = imag_part ~= 0;
imag_count   = sum(is_imag_binary);
real_count   = length(polystruct.coef_vec)-imag_count-1;

fprintf('  found %d real roots and %d imaginary roots\n',real_count,imag_count);

% now plot all real roots within the x range of interst
hold on
for i=1:length(r)
    if imag(r(i))==0 % then no imaginary part
        if and(r(i) >= polystruct.x_range(1),r(i) <= polystruct.x_range(2))
                h2 = plot( r(i), 0, 'o' );
                set(h2,'Color',polystruct.plot_color_string);
        else
            fprintf('  Real root %f not within range\n',r(i));
        end
    end
end


