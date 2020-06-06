%pgm to create example images
save_subsamples('case_polo')
save_subsamples('case_t')
save_subsamples('hku_polo')
save_subsamples('interlochen')
save_subsamples('orange_t')
save_subsamples('striped_shirt')
save_subsamples('white_dress')

compress_training_data; %does a LOT...and saves results as 
%save('training_data','all_patterns')
%save('best_cube_indices','best_cubes')

