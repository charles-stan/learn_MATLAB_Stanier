function water_psat = genutil_water_pvap( temp_C )
% this function water_psat = water_psat( temp_C ) returns 
% the saturation vapor pressure of water in mbar
% based on the equations in Pandis p. 781

if or(temp_C < -50,temp_C > 50 )
    error('Temp out of range for water vapor equation')
end

a = [  6.107799961;
       4.436518521E-1;
       1.428945805E-2;
       2.650648471E-4;
       3.031240396E-6;
       2.034080948E-8;
       6.136820929E-11 ];

water_psat = 0;
for i=0:6
    water_psat = water_psat + a(i+1).*temp_C.^i;
end
