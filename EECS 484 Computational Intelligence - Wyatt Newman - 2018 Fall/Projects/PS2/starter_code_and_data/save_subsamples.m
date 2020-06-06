function save_subsamples(fname_root)
%program to read in an image and create a collection of 
%transformed output images--multiple samples from multiple snapshots of
%single garment
ndivs = 8;
nsamps = 10000; %this many pixels per sample, i.e. sub-image
n_subimages = 11 %this many transformed images from each input image
%ncubes_compressed = 10;

%fname_root = 'case_polo';
fname_read = strcat(fname_root,'1.png')
%fname = 'case_polo1.png'
A=imread(fname_read);
image(A);

%w/ chosen occupancy resolution, there are this many cubes:
ncubes_large = ndivs*ndivs*ndivs %organize images by memberships in cubes in chosen color space
%store sub-samples in a matrix, with each column = a transformed image,
%ncubes_large x 1
%large_cubes_matrix= zeros(ncubes_large,n_subimages);

%initialize large_cubes_matrix to first column vector
[ color_samps1, scaled_color_samps, large_cubes_matrix ] = sample_colors_from_image( A,nsamps, ndivs );
for ipic=1:n_subimages-1
    [ color_samps1, scaled_color_samps, cubes_vec ] = sample_colors_from_image( A,nsamps, ndivs );
    large_cubes_matrix = [large_cubes_matrix,cubes_vec];
    %large_cubes_matrix(:,ipic) = cubes_vec; %save each sampled, transformed image
end


fname_read = strcat(fname_root,'2.png') %read in second snapshot
A=imread(fname_read);
image(A); %display--just for debug
for ipic=1:n_subimages
    [ color_samps1, scaled_color_samps, cubes_vec ] = sample_colors_from_image( A,nsamps, ndivs );
    large_cubes_matrix = [large_cubes_matrix,cubes_vec];
end

fname_read = strcat(fname_root,'3.png') %read in third snapshot
A=imread(fname_read);
image(A); %display--just for debug
for ipic=1:n_subimages
    [ color_samps1, scaled_color_samps, cubes_vec ] = sample_colors_from_image( A,nsamps, ndivs );
    large_cubes_matrix = [large_cubes_matrix,cubes_vec];
end

[ncubes,npics]= size(large_cubes_matrix)
net_vec = zeros(ncubes,1);
for ipic=1:npics
    net_vec=net_vec+large_cubes_matrix(:,ipic);
end

fname_save = strcat(fname_root,'_cubes_matrix')
save(fname_save,'large_cubes_matrix')
fname_save = strcat(fname_root,'_net_vec')
save(fname_save,'net_vec')

return

