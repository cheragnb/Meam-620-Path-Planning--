function [C] = collide(map, points)
% COLLIDE Test whether points collide with an obstacle in an environment.
% C = collide(map, points).  points is an M-by-3 matrix where each
% row is an (x, y, z) point.  C in an M-by-1 logical vector;
% C(i) = 1 if M(i, :) touches an obstacle and is 0 otherwise.
%%
%clc;

%map = MAP;
%points
%points = [10 100 1];
%
%
% points = [0.0  -1.0 2.0;
%           3.0  17.0 4.0;
%           0.0  -5.0 0.5;
%           0.0 2.0 1.0;
%           3.0 18.5 4.5];
%


x_points = points(:,1);
y_points = points(:,2);
z_points = points(:,3);

%removing values not between limits and equating to first obstacle

x_points( (points(:,1) <= map.xyz_lim(1,1)) | (points(:,1) >= map.xyz_lim(2,1))) = map.f_obs(1);
y_points( (points(:,2) <= map.xyz_lim(1,2)) | (points(:,2) >= map.xyz_lim(2,2))) = map.f_obs(2);
z_points( (points(:,3) <= map.xyz_lim(1,3)) | (points(:,3) >= map.xyz_lim(2,3))) = map.f_obs(3);


%zeroing
x_points = x_points - map.xyz_lim(1,1);
y_points = y_points - map.xyz_lim(1,2);
z_points = z_points - map.xyz_lim(1,3);

%normalizing
x_points = x_points/map.xy_res;
y_points = y_points/map.xy_res;
z_points = z_points/map.z_res;

norm_points = [x_points  y_points  z_points];
%add one to everything to finalize normalization
norm_points = norm_points + 1;

%flooring norm_points
norm_points = floor(norm_points);

points_vec = sub2ind(size(map.map_val),norm_points(:,1),norm_points(:,2),norm_points(:,3));
OBS = find(map.map_val);
C = ismember(points_vec,OBS);

%%
end
