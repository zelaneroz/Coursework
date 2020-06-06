function [ smaller_cubes_vec_matrix,best_cubes ] = compress_cubes( ncubes_result,input_cubes_vec_matrix )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%input_cubes_vec_matrix: each column is an image, represented as membership
%in list of cubes, ndims*ndims*ndims

%find out how much variance there is for each cube, across images
std_vec =  std(input_cubes_vec_matrix')
[Y,I] = sort(std_vec); %sort the cubes by variance--presumes strong variance -> a good indicator
ncubes_large = size(I,2); %there are this many cubes
nvecs = size(input_cubes_vec_matrix,2); %and there are this many images
%best_cube = I(ncubes_large); %this is the cube index that has the greatest variance
best_cubes = I(ncubes_large-ncubes_result+1:ncubes_large);
best_cube = best_cubes(1);
%start constructing a subspace projection of only the most influential
%cubes--choose to retain only ncubes_result number of cubes in the reduced
%vector
smaller_cubes_vec_matrix = input_cubes_vec_matrix(best_cube,:);
for i=2:ncubes_result
    next_best_cube = best_cubes(i);
    next_best_row = input_cubes_vec_matrix(next_best_cube,:);
    smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;next_best_row];
end
%smaller_cubes_vec_matrix has a smaller-dimensional representation of each
%of the images, stored as each column is an image
