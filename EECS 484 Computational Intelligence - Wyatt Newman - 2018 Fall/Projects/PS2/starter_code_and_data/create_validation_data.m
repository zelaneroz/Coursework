%sample the original images and save snippets
%snippets are some number of randomly sampled pixels, 
%transformed into HSV, scaled, and converted to rounded integers at
%specified resolution.  
n_subimages=11; %%take this many resamples of each *.png
n_pixel_samps = 10000; %this many pixels per sample, i.e. sub-image

save_validation_subsamples('case_polo', n_subimages,n_pixel_samps)
save_validation_subsamples('case_t', n_subimages,n_pixel_samps)
save_validation_subsamples('hku_polo', n_subimages,n_pixel_samps)
save_validation_subsamples('interlochen', n_subimages,n_pixel_samps)
save_validation_subsamples('orange_t', n_subimages,n_pixel_samps)
save_validation_subsamples('striped_shirt', n_subimages,n_pixel_samps)
save_validation_subsamples('white_dress', n_subimages,n_pixel_samps)

load best_cube_indices 
best_cubes %indices of best cubes, implies how to compress the sample data--as created by 

load case_polo_cubes_matrix_v
[nfeatures_large,npatterns]=size(large_cubes_matrix)
validation_attributes=ones(1,npatterns)*1; %first fabric
[smaller_cubes_vec_matrix] = compress_cubes_given_indices(best_cubes, large_cubes_matrix)
all_patterns = smaller_cubes_vec_matrix;
size(all_patterns)
ans = input('donw w/ case polo; enter 1: ')

load case_t_cubes_matrix_v
[nfeatures_large,npatterns]=size(large_cubes_matrix)
validation_attributes_new=ones(1,npatterns)*2; %first fabric
validation_attributes=[validation_attributes,validation_attributes_new];
[smaller_cubes_vec_matrix] = compress_cubes_given_indices(best_cubes, large_cubes_matrix)
all_patterns=[all_patterns,smaller_cubes_vec_matrix];
size(all_patterns)
ans = input('done w/ case T; enter 1: ')

load hku_polo_cubes_matrix_v
[nfeatures_large,npatterns]=size(large_cubes_matrix)
validation_attributes_new=ones(1,npatterns)*3; %first fabric
validation_attributes=[validation_attributes,validation_attributes_new];
[smaller_cubes_vec_matrix] = compress_cubes_given_indices(best_cubes, large_cubes_matrix)
all_patterns=[all_patterns,smaller_cubes_vec_matrix];
size(all_patterns)
ans = input('done w/ HKU polo; enter 1: ')

load interlochen_cubes_matrix_v
[nfeatures_large,npatterns]=size(large_cubes_matrix)
validation_attributes_new=ones(1,npatterns)*4; %first fabric
validation_attributes=[validation_attributes,validation_attributes_new];
[smaller_cubes_vec_matrix] = compress_cubes_given_indices(best_cubes, large_cubes_matrix)
all_patterns=[all_patterns,smaller_cubes_vec_matrix];
size(all_patterns)
ans = input('done w/ interlochen T; enter 1: ')

load orange_t_cubes_matrix_v
[nfeatures_large,npatterns]=size(large_cubes_matrix)
validation_attributes_new=ones(1,npatterns)*5; %first fabric
validation_attributes=[validation_attributes,validation_attributes_new];
[smaller_cubes_vec_matrix] = compress_cubes_given_indices(best_cubes, large_cubes_matrix)
all_patterns=[all_patterns,smaller_cubes_vec_matrix];
size(all_patterns)
ans = input('done w/ orange T; enter 1: ')

load striped_shirt_cubes_matrix_v
[nfeatures_large,npatterns]=size(large_cubes_matrix)
validation_attributes_new=ones(1,npatterns)*6; %first fabric
validation_attributes=[validation_attributes,validation_attributes_new];
[smaller_cubes_vec_matrix] = compress_cubes_given_indices(best_cubes, large_cubes_matrix)
all_patterns=[all_patterns,smaller_cubes_vec_matrix];
size(all_patterns)
ans = input('done w/ striped shirt; enter 1: ')

load white_dress_cubes_matrix_v
[nfeatures_large,npatterns]=size(large_cubes_matrix)
validation_attributes_new=ones(1,npatterns)*7; %first fabric
validation_attributes=[validation_attributes,validation_attributes_new];
[smaller_cubes_vec_matrix] = compress_cubes_given_indices(best_cubes, large_cubes_matrix)
all_patterns=[all_patterns,smaller_cubes_vec_matrix];
[nfeatures,npatterns]= size(all_patterns)
%tack on the attribute labels:
all_patterns = [all_patterns;validation_attributes];
display('done w/ white shirt')
save('validation_data','all_patterns')
return

