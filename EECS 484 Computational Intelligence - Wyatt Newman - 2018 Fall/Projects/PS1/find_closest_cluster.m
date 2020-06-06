%find_closest_cluster.m  EDIT THIS -- FIXED by smh : 9/1/15
%given assigned value for ipat, cycle through all clusters and find which
%cluster is closest to ipat.  Resulting cluster index is set in  closestClust

%store the current pattern's attribute vector
pattern_features = feature_scaled_vals(ipat);

%initially, pick the first cluster
closestClust = 1;

%initialize distance variables
curr_dist = 0.0;
closest_dist = 0.0;

for i=1:nclusters   
    %get the distance to the current cluster
    curr_dist = norm(pattern_features - cluster_centroids(i));
    
    %get the distance to the closest cluster found thus far
    closest_dist = norm(pattern_features - cluster_centroids(closestClust));
    
    %compare the new distance with the old distance
    if curr_dist < closest_dist
        %set the closest cluster to the current one
        closestClust = i;
    end
end

closestClust;
