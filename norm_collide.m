function [C] = norm_collide(map, points)
% COLLIDE Test whether points collide with an obstacle in an environment.
% C = collide(map, points).  points is an M-by-3 matrix where each
% row is an (x, y, z) point.  C in an M-by-1 logical vector;
% C(i) = 1 if M(i, :) touches an obstacle and is 0 otherwise.
%%
%clc;

%map = MAP;
%points
%points = [10 100 1];

% points = [0.0  -1.0 2.0;
%           3.0  17.0 4.0;
%           0.0  -5.0 0.5;
%           0.0 2.0 1.0;
%           3.0 18.5 4.5];
%
x_points = points(:,1);
y_points = points(:,2);
z_points = points(:,3);

[l,b,h] = size(map.map_val);

if ...
        ((x_points < 1 || (x_points > l)) || ...
        ( y_points < 1  || (y_points > b)) || ...
        ( z_points < 1  || (z_points > h)))
    C = [1];
%     x_points
%     y_points
%     z_points
%     
%  disp(  '-----hit a wall-----');
   return
end

norm_points = [x_points  y_points  z_points];

%removing values not between limits and equating to first obstacle
points_vec = sub2ind(size(map.map_val),norm_points(:,1),norm_points(:,2),norm_points(:,3));
OBS = find(map.map_val);
C = ismember(points_vec,OBS);

end
