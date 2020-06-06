function success_rate = kmeans_clustering()

%main clustering program
%uses 8 helper scripts: seed_clusters.m, find_minmax_feature_vals.m,
%scale_all_feature_vals.m, do_clustering.m, find_closes_cluster.m,

%remove_pattern_from_cluster.m, put_pattern_into_cluster.m,
%reassign_patterns.m

%start by loading training data
%format is: pattern code, attribute value, features 1 through nfeatures
%clear all

nclusters=200  %you must choose how many clusters to assume--edit this
max_passes=10 %set max number of sweeps through pattern reassignments...
  % used in do_clustering.m

load training_data; %loads "all_patterns"
%transformed, compressed samples from 7 shirts
%use clustering to try to classify garments

[nfeatures,npics] = size(all_patterns); 
raw_features = all_patterns(1:nfeatures-1,:); %strip off classifications
raw_features = raw_features'; %transpose, so each pattern is a ROW
attributes=all_patterns(nfeatures,:); %these are the associated attributes= garment code
[npatterns,nfeatures]=size(raw_features) %number of rows is number of patterns in training set

%vectors to store max and min values of each feature
[feature_max_vals,feature_min_vals] = find_minmax_feature_vals(raw_features)

%scale all feature values
[feature_scaled_vals] = scale_all_feature_values(feature_max_vals,feature_min_vals,raw_features);


% data organization:
%each pattern belongs to a cluster; cluster #0==> unassigned
pattern_assignments = zeros(npatterns,1); %initialize all patterns to no cluster assignment

%cluster membership matrix: each row is a cluster, each column is a pattern; entries are 1 or 0 to
%mark if respective pattern belongs to respective cluster 
cluster_rosters=zeros(nclusters,npatterns);

%cluster properties: rows are clusters;
% cluster_populations is number of members;
% cluster attributes is avg attribute of each cluster
%cluster_centroids: cols are avg feature values for each cluster
cluster_populations=zeros(nclusters,1); %start w/ zero population in each cluster
cluster_attributes=zeros(nclusters,1); %average attributes need to be properly initialized 
cluster_centroids=zeros(nclusters,nfeatures); %need to be properly initialized

%seed clusters:
%pick a random pattern number:
for icluster=1:nclusters
    while(cluster_populations(icluster)==0)
        icluster %print out cluster in progress
        ipat = ceil(npatterns*rand) % pick a random pattern
        if (pattern_assignments(ipat)==0) %test if this pattern is unassigned
            pattern_assignments(ipat)=icluster; %assign this pattern to belong to icluster
            cluster_populations(icluster)=1; %this cluster now has one pattern
            cluster_attributes(icluster)=attributes(ipat); %save the attribute value verbatim
            cluster_centroids(icluster,:)=feature_scaled_vals(ipat,:); %copy sclaed feature values = centroid for single member
            cluster_rosters(icluster,ipat)=1; %put tick in this cluster/pattern correspondence
        end  %end if--which may complete assignment for this cluster
    end %end while--repeats until find a suitable initial pattern for the cluster
end %end for--complete the initialization for every cluster

%max_passes
nchanges=1;
npasses=0;
%display('nchanges: ');
while ( (nchanges>0)&&(npasses<max_passes))
  [ nchanges,pattern_assignments,cluster_populations, cluster_attributes,cluster_centroids, cluster_rosters ] = do_reclustering( pattern_assignments,cluster_populations,cluster_attributes,attributes,cluster_centroids,cluster_rosters,feature_scaled_vals );
  nchanges
  npasses = npasses+1;
end

% display('cluster_populations')
% cluster_populations
% display('cluster_attributes')
% cluster_attributes

%TEST FOR CONSISTENCY:
score=0;
cluster_errs=zeros(nclusters,1);
for ipat=1:npics
    %display('true attribute = ');
    true_attribute = attributes(ipat)
    closestClust = find_closest_cluster(ipat,feature_scaled_vals,cluster_centroids);
    pattern_assignments(ipat)
    
    %round to get the nearest integer attribute
    kmeans_inferred_attribute = round(cluster_attributes(closestClust), 1);
    if (kmeans_inferred_attribute==true_attribute)
        score = score+1;
    else
        cluster_errs(closestClust)=cluster_errs(closestClust)+1;
    end
    
end

% display('score = ')
% score

% display('of npics = ');
% npics

%display('% success rate: ')
success_rate = score/npics;
%success_rate

% display('num errs: ');
% nerrs = npics-score

% display('cluster errs: ');
% cluster_errs'

save('clusters_from_training')
end