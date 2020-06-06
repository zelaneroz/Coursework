function [ color_samps, scaled_color_samps, cubes_vec ] = sample_colors_from_image( image_in,nsamps,ndivs)
%sample_colors_from_image read in an image; output transformed samples
%   given a presumed 640x480 image, crop it to a window near the center
%   convert this sub-image to HSV
%   scale the S term so all 3 components range ~[0,1]
%   sample this transformed image w/ nsamps random samples of pixels
%   for each such pixel, classify it as belonging to one of
%   ndivs*ndivs*ndivs cubes.  List these cubes in a vector (string out the ndivs x ndivs x ndivs cube)
%   and populate this structure with number of samples that are classfied
%   within each cube
%   return "cubes_vec" as the most useful output;  this will be a feature
%   vector;  Later, compress this feature vector into a smaller-dimensional
%   feature vector of the most important components

%assumes 640 by 480 color image input, RGB
%let's crop A to make image B
%size(image_in);
B = image_in(200:400,150:250,:);
%C = B;
B = rgb2hsv(B);
%B(:,2) = B(:,2)*2; %double the S component
%B = round(B*ndivs);
%image(B)
%reorganize B into a list of color vecs:
nrows = size(B,1);
ncols = size(B,2);
nclr = size(B,3);
clrvecs = reshape(B,nrows*ncols,3);

cubes_vec = zeros(ndivs*ndivs*ndivs,1);

%randomly sample nsamps from this list of color vecs
npts_clrvecs = size(clrvecs,1);
%nsamps = 100;
rng('shuffle');
color_samps = zeros(nsamps,3);
for i=1:nsamps
    index = unidrnd(npts_clrvecs);
    color_samps(i,:) = clrvecs(index,:);  
end
scaled_color_samps= color_samps;
scaled_color_samps(:,2)=scaled_color_samps(:,2)*2;
scaled_color_samps = round(scaled_color_samps*(ndivs-1));

%try normalizing the colors:
% for i=1:nsamps
%     color_samps(i,:)= color_samps(i,:)/(sum(color_samps(i,:)));
% end
for i=1:nsamps
    color = scaled_color_samps(i,:);
    cubenum = color(1)*ndivs*ndivs+color(2)*ndivs+color(3)+1;
    cubes_vec(cubenum)= cubes_vec(cubenum)+1;
end
%cubes_vec
end

