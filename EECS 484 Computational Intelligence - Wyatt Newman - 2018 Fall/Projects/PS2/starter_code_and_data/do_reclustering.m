function [ nchanges,pattern_assignments,cluster_populations, cluster_attributes,cluster_centroids, cluster_rosters ] = do_reclustering( pattern_assignments,cluster_populations,cluster_attributes,attributes,cluster_centroids,cluster_rosters,feature_scaled_vals )

nchanges=0;
%n_reclusters=0;
[npatterns,nfeatures]=size(feature_scaled_vals);

for ipat=1:npatterns
   % ipat %debug echo--report current pattern under consideration
   % attributes(ipat)
    current_cluster=pattern_assignments(ipat); %and current cluster assignment of this pattern
    closestClust = find_closest_cluster(ipat,feature_scaled_vals,cluster_centroids);
    %pattern_assignments
    if (current_cluster ~=closestClust) %need to move this pattern to a new cluster
        nchanges=nchanges+1;
        current_cluster=pattern_assignments(ipat);
        if (current_cluster>0) %remove only if currently assigned
            pattern_assignments(ipat)=0; %unassign pattern ipat from any cluster
            newpop=cluster_populations(current_cluster)-1;
            cluster_populations(current_cluster)=newpop; %decrement population of current cluster
            old_attribute=cluster_attributes(current_cluster);
            pat_attribute=attributes(ipat); %attribute value of pattern ipat
            cluster_attributes(current_cluster)=old_attribute*(newpop+1)/newpop-pat_attribute/newpop;
            cluster_centroids(current_cluster,:)=cluster_centroids(current_cluster,:)*(newpop+1)/newpop-feature_scaled_vals(ipat,:)/newpop; %remove influence of features of deleted pattern
            cluster_rosters(current_cluster,ipat)=0; %remove this pattern from the current_cluster's roster
        end  %done removing pattern from cluster, if necessary
        %now, assign this pattern to the closest cluster:
        if (pattern_assignments(ipat)==0) %only add if current pattern is not assigned (e.g. recently removed)
            pattern_assignments(ipat)=closestClust; %assign pattern ipat to cluster closestClust
            newpop=cluster_populations(closestClust)+1;
            cluster_populations(closestClust)=newpop;
            old_attribute=cluster_attributes(closestClust);
            new_attribute=attributes(ipat); %attribute value of pattern ipat
            cluster_attributes(closestClust)=old_attribute*(newpop-1)/newpop+new_attribute/newpop;
            cluster_centroids(closestClust,:)=cluster_centroids(closestClust,:)*(newpop-1)/newpop+feature_scaled_vals(ipat,:)/newpop; %include influence of weighted avg of new pattern features
            cluster_rosters(closestClust,ipat)=1; %record that ipat is a member of cluster closestCluster
        end  %end if--which may complete addition to this cluster
    end
end

