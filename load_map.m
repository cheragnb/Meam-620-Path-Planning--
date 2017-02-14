function map = load_map(filename, xy_res, z_res, margin)
% LOAD_MAP Load a map from disk.
%  MAP = LOAD_MAP(filename, xy_res, z_res, margin).  Creates an occupancy grid
%  map where a node is considered fill if it lies within 'margin' distance of
%  on abstacle.
%%

clc;
xy_res = 1;
z_res= 1;
filename = 'testmap.txt';
global MAP;
margin = 0.2;


%Parse txt file

fid = fopen(filename);
cells = textscan(fid,'%s %f %f %f %f %f %f %f %*f %*f %*f', 'CommentStyle', '#');
fclose(fid);
xyz_lim_index = find(strcmp(cells{1}, 'boundary'));

%converting cells into matrix and removing the first column 
matrix = cell2mat(cells(2:7));

% Delete the coordinate elements row
matrix(xyz_lim_index , :)=[];

%xyz limits
xyz_lim = [ cells{2}(xyz_lim_index) cells{3}(xyz_lim_index) cells{4}(xyz_lim_index);
            cells{5}(xyz_lim_index) cells{6}(xyz_lim_index) cells{7}(xyz_lim_index)];

%size of the matrix rounded up, NO -> added rez to include edge         
x_len = (xyz_lim(2,1)-xyz_lim(1,1));
%x_len = x_len + xy_res;
x_len = x_len/xy_res;
x_len = floor(x_len);

y_len = (xyz_lim(2,2)-xyz_lim(1,2));
%x_len = x_len + xy_res;
y_len = y_len/xy_res;
y_len = floor(y_len);

z_len = (xyz_lim(2,3)-xyz_lim(1,3));
%x_len = x_len + xy_res;
z_len = z_len/z_res;
z_len = floor(z_len);

%range of X,Y,Z, ignoring forst one 
X = (   xyz_lim(1,1)    +xy_res    :xy_res:    xyz_lim(2,1)    )/xy_res;
Y = (   xyz_lim(1,2)    +xy_res    :xy_res:    xyz_lim(2,2)    )/xy_res;
Z = (   xyz_lim(1,3)    +z_res     :z_res:     xyz_lim(2,3)    )/z_res;
    
%meshing the above, Y and X swapped in meshgrid
[Y_mesh,X_mesh,Z_mesh] = meshgrid(Y,X,Z);

%extracting first obstacle coordinates
f_obs = [matrix(1,1) matrix(1,2) matrix(1,3)];

%blank matrix
 map_val = false(x_len,y_len,z_len);
%normalizing natrix and using margin
matrix(:,1:2) = (matrix(:,1:2) - margin)    /xy_res;
matrix(:,3) =   (matrix(:,3) - margin)      /z_res;

matrix(:,4:5) = (matrix(:,4:5) + margin)/xy_res;
matrix(:,6) =   (matrix(:,6) + margin)  /z_res;

[r , ~] = size(matrix);

for i= 1:r

    x_obs = floor(matrix(i,1)):ceil(matrix(i,4))  ; 
    y_obs = floor(matrix(i,2)):ceil(matrix(i,5))  ;
    z_obs = floor(matrix(i,3)):ceil(matrix(i,6))  ;
       
    %meshing the obstacles
    [X_obs,Y_obs,Z_obs] = meshgrid(x_obs,y_obs,z_obs);
    
    %creating logical map
    map_val = map_val | ismember(X_mesh,X_obs) & ismember(Y_mesh,Y_obs) & ismember(Z_mesh,Z_obs);

end

map_val = [ 0 1 0;
            0 1 0;
            0 0 0;];


map = struct('map_val',map_val,'xy_res',xy_res,'z_res',z_res,'xyz_lim',xyz_lim,'f_obs',f_obs);


MAP = map;
%map_val
%%


end
