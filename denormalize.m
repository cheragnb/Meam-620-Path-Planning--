function [xyz] = denormalize(i,j,k, map)
%%
% x_start = map.xyz_lims(1,1);
% y_start = map.xyz_lims(1,2);
% z_start = map.xyz_lims(1,3);

%map = MAP;

% i = 10;
% j = 5;
% k = 3;
%subtracting 1 
i = i + 1 ; 
j = j + 1;
k = k + 1;

%de -normalizing 
x_points = i*map.xy_res;
y_points = j*map.xy_res;
z_points = k*map.z_res;

%de - zeroing 
x_points = x_points + map.xyz_lim(1,1);
y_points = y_points + map.xyz_lim(1,2);
z_points = z_points + map.xyz_lim(1,3);

%normalizing 
[xyz] = [x_points  y_points  z_points];

%%
end
