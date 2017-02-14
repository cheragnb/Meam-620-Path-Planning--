function plot_path(map, path)
% PLOT_PATH Visualize a path through an environment
%   PLOT_PATH(map, path) creates a figure showing a path through the
%   environment.  path is an N-by-3 matrix where each row corresponds to the
%   (x, y, z) coordinates of one point along the path.

%%
% https://en.wikipedia.org/wiki/Dijkstra's_algorithm
clc;
map = [ 0 1 0;
        0 1 0;
        0 0 0;]

[l,b,h] = size(map);
% node list
Q = (1:l*b*h);
%dist and prev list
dist =  ones(1,l*b*h)*inf;

while(Q)
    


    


end