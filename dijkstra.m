function [path, num_expanded] = dijkstra(map, start, goal, astar)
% DIJKSTRA Find the shortest path from start to goal.
%   PATH = DIJKSTRA(map, start, goal) returns an M-by-3 matrix, where each row
%   consists of the (x, y, z) coordinates of a point on the path.  The first
%   row is start and the last row is goal.  If no path is found, PATH is a
%   0-by-3 matrix.  Consecutive points in PATH should not be farther apart than
%   neighboring cells in the map (e.g.., if 5 consecutive points in PATH are
%   co-linear, don't simplify PATH by removing the 3 intermediate points).
%
%   PATH = DIJKSTRA(map, start, goal, astar) finds the path using euclidean
%   distance to goal as a heuristic if astar is true.
%
%   [PATH, NUM_EXPANDED] = DIJKSTRA(...) returns the path as well as
%   the number of points that were visited while performing the search.

%%
% https://en.wikipedia.org/wiki/Dijkstra's_algorithm
clc;
% changing this might not affect much
map = MAP.map_val;
start = [1 1 1] ;
i = start(1)/MAP.xy_res;
j = start(2)/MAP.xy_res;
k = start(3)/MAP.z_res;

[l,b,h] = size(map);
% node list
Q = (1:l*b*h);
%dist and prev list
dist = ones(1,l*b*h)*inf;
prev = ones(1,l*b*h)*-1;

v = sub2ind(size(map),i,j,k);
dist(v)  = 0;

while(Q)
    Q;
    [~,u] = min(dist);
    Q(u) = [];
    %look down %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    i = i+1;   j=j;
     %check for collision, %collide = 0 no obs, 1 obs
    if( norm_collide(MAP,[i j k]) == 0)
        %'here 1'
        v = sub2ind(size(map),i,j,k);
        %check if element already visited, find = 0, Q not in list,already
        %done, dont test
        presence = find(Q == v);
        if(~ isempty(presence))
         %   'here 2'
            alt = dist(u) + 1;
            if (alt < dist(v))
                %'here 3'
         
                dist(v) = alt;
                prev(v) = u;
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%end
% if nargin < 4;
%     astar = false;
% end
% path = [];
% num_expanded = 0;
end
