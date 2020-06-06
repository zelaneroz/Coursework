%compress the training data

load case_polo_net_vec
net_vec_matrix = net_vec;

load case_t_net_vec
net_vec_matrix = [net_vec_matrix,net_vec];

load hku_polo_net_vec;
net_vec_matrix = [net_vec_matrix,net_vec];

load interlochen_net_vec;
net_vec_matrix = [net_vec_matrix,net_vec];

load orange_t_net_vec;
net_vec_matrix = [net_vec_matrix,net_vec];

load striped_shirt_net_vec;
net_vec_matrix = [net_vec_matrix,net_vec];

load white_dress_net_vec;
net_vec_matrix = [net_vec_matrix,net_vec];

ncubes=10 %arbitrarily select this many features to retain--
          %but choose these features (color boxes, extracte from 512 boxes)
          %wisely.  Choose them to be the most distinguishing boxes.
          %BETTER: use principal components to select weighted sums of
          %boxes

[smaller_cubes_vec_matrix,best_cubes] = compress_cubes(ncubes, net_vec_matrix)
[nfeatures,ngarments]= size(smaller_cubes_vec_matrix)
for ipic =1:ngarments
    smaller_cubes_vec_matrix(:,ipic) = smaller_cubes_vec_matrix(:,ipic)/norm(smaller_cubes_vec_matrix(:,ipic));
end

load case_polo_cubes_matrix
smaller_cubes_vec_matrix= compress_matrix(best_cubes,large_cubes_matrix);
%add feature component as last element:
nsamps = size(smaller_cubes_vec_matrix,2)
feature_row_vec = ones(1,nsamps)*1;
smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;feature_row_vec]
all_patterns = smaller_cubes_vec_matrix;

load case_t_cubes_matrix
smaller_cubes_vec_matrix= compress_matrix(best_cubes,large_cubes_matrix);
%add feature component as last element:
nsamps = size(smaller_cubes_vec_matrix,2)
feature_row_vec = ones(1,nsamps)*2;
smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;feature_row_vec]
all_patterns = [all_patterns,smaller_cubes_vec_matrix];

load hku_polo_cubes_matrix
smaller_cubes_vec_matrix= compress_matrix(best_cubes,large_cubes_matrix);
%add feature component as last element:
nsamps = size(smaller_cubes_vec_matrix,2)
feature_row_vec = ones(1,nsamps)*3;
smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;feature_row_vec]
all_patterns = [all_patterns,smaller_cubes_vec_matrix];

load interlochen_cubes_matrix
smaller_cubes_vec_matrix= compress_matrix(best_cubes,large_cubes_matrix);
%add feature component as last element:
nsamps = size(smaller_cubes_vec_matrix,2)
feature_row_vec = ones(1,nsamps)*4;
smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;feature_row_vec]
all_patterns = [all_patterns,smaller_cubes_vec_matrix];

load orange_t_cubes_matrix
smaller_cubes_vec_matrix= compress_matrix(best_cubes,large_cubes_matrix);
%add feature component as last element:
nsamps = size(smaller_cubes_vec_matrix,2)
feature_row_vec = ones(1,nsamps)*5;
smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;feature_row_vec]
all_patterns = [all_patterns,smaller_cubes_vec_matrix];

load striped_shirt_cubes_matrix
smaller_cubes_vec_matrix= compress_matrix(best_cubes,large_cubes_matrix);
%add feature component as last element:
nsamps = size(smaller_cubes_vec_matrix,2)
feature_row_vec = ones(1,nsamps)*6;
smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;feature_row_vec]
all_patterns = [all_patterns,smaller_cubes_vec_matrix];

load white_dress_cubes_matrix
smaller_cubes_vec_matrix= compress_matrix(best_cubes,large_cubes_matrix);
%add feature component as last element:
nsamps = size(smaller_cubes_vec_matrix,2)
feature_row_vec = ones(1,nsamps)*7;
smaller_cubes_vec_matrix = [smaller_cubes_vec_matrix;feature_row_vec]
all_patterns = [all_patterns,smaller_cubes_vec_matrix];

save('training_data','all_patterns')
save('best_cube_indices','best_cubes')