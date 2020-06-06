function [ smaller_cubes_vec_matrix ] = compress_matrix(best_cubes_indices,large_cubes_matrix)
%given a matrix containing transformed samples of pictures, compress these
%vectors by extracting the features only from the list in
%best_cubes_indices;  normalize each vector; return the result as a
%corresponding compressed matrix of images by column vector
nfeatures = size(best_cubes_indices,2)
npics = size(large_cubes_matrix,2)
smaller_cubes_vec_matrix = zeros(nfeatures,npics);
for ifeature = 1:nfeatures
    cube_index = best_cubes_indices(ifeature)
    smaller_cubes_vec_matrix(ifeature,:) = large_cubes_matrix(cube_index,:);
end
%normalize the column vecs:
for ipic = 1:npics
    smaller_cubes_vec_matrix(:,ipic) = smaller_cubes_vec_matrix(:,ipic)/norm(smaller_cubes_vec_matrix(:,ipic));
end


end

