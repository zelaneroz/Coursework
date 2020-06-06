function [smaller_cubes_vec_matrix] = compress_cubes_given_indices(best_cubes, net_vec_matrix)

%subspace projection of matrix of feature vecs, given list of key features=
%best_cubes
%   Detailed explanation goes here
%input_cubes_vec_matrix: each column is an image, represented as membership
%in list of cubes, ndims*ndims*ndims
%ASSUMES net_vec_matrix has feature vecs in COLS
%each column is a separate image


nvecs = size(net_vec_matrix,2); % there are this many images
nfeatures_reduced = size(best_cubes,2); %will retain this many features in reduced feature vecs
%start constructing a subspace projection of only the most influential
%cubes--choose to retain only ncubes_result number of cubes in the reduced
%vector
smaller_cubes_vec_matrix = net_vec_matrix(best_cubes(1),:);
for i=2:nfeatures_reduced
    next_best_cube = best_cubes(i);
    next_best_row = net_vec_matrix(next_best_cube,:);
    smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;next_best_row];
end
%smaller_cubes_vec_matrix has a smaller-dimensional representation of each
%of the images, stored as each column is an image
