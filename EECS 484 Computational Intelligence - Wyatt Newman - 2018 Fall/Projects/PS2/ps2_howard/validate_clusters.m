function success_rate = validate_clusters()
%fnc to classify pics based on trained clusters
%clear all
load clusters_from_training
nclusters = size(cluster_attributes,1)

% CHOOSE A VALIDATION FILE TO LOAD--USE VALIDATION_DATA_ANON FOR YOUR SOLUTION
%load training_data %test using the training data--should get identical results
%load validation_data; %loads "validation_patterns"; use to debug your code
load validation_data_anon; %data wlll be in array "all_patterns"; classify these patterns for your solution


%transformed, compressed samples from 7 shirts
%use clustering to try to classify garments

[nfeatures,npics] = size(all_patterns); 
%OVERWRITE "raw_features" so it now contains the test (validation) data
raw_features = all_patterns(1:nfeatures-1,:); %strip off classifications
raw_features = raw_features'; %transpose, so each pattern is a ROW
%NOTE: attributes are all set to 0 for the anonymous validation data!
attributes=all_patterns(nfeatures,:); %these are the associated attributes= garment code
[npatterns,nfeatures]=size(raw_features) %number of rows is number of patterns in training set

%vectors to store max and min values of each feature
%NO--use EXISTING scaling vectors
%[feature_max_vals,feature_min_vals] = find_minmax_feature_vals(raw_features)

%scale all feature values
[feature_scaled_vals] = scale_all_feature_values(feature_max_vals,feature_min_vals,raw_features);


%now, associate each pattern with a cluster, infer its attribute, and test
%how we did
classification_results = zeros(1,npics); %your answers go here
score=0;
cluster_errs=zeros(nclusters,1);
for ipat=1:npics
    %display('true attribute = ');
    true_attribute = attributes(ipat); % this is unknown for the anonymous validation data
    %find the closest cluster
    chosen_cluster = find_closest_cluster(ipat,feature_scaled_vals,cluster_centroids);
    kmeans_inferred_attribute=cluster_attributes(chosen_cluster);
    if (kmeans_inferred_attribute==true_attribute)
        score = score+1;
    end
    classification_results(ipat) = kmeans_inferred_attribute; 
    
end

%NOTE: your clustering results should be good using the validation_data
%file.  However, the anonymous validation patterns do not include the
%classification answers, so your clustering will claim 100% errors.  Don't
%worry about that.

%display('score = ')
%score
%display('of npics = ');
%npics
%display('num errs: ');
%nerrs = npics-score
%display('% success rate: ')
success_rate = score/npics; 

% display('cluster errs: ');
% cluster_errs'
save('classification_results','classification_results')
%UPLOAD YOUR RESULT FILE 'classification_results' TO BLACKBOARD FOR YOUR
%ANONYMOUS DATA CLASSIFICATION RESULTS
end